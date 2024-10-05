/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "MotdMgr.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "ScriptMgr.h"
#include "Timer.h"
#include "Tokenize.h"
#include "WorldPacket.h"
#include <iterator>

#include <iostream>
#include <string>
#include <sstream>
#include <iomanip>
#define STRINGIFY(x) #x
#define TOSTRING(x) STRINGIFY(x)

// 将月份缩写转换为数字
int monthToNumber(const std::string& month) {
    if (month == "Jan") return 1;
    if (month == "Feb") return 2;
    if (month == "Mar") return 3;
    if (month == "Apr") return 4;
    if (month == "May") return 5;
    if (month == "Jun") return 6;
    if (month == "Jul") return 7;
    if (month == "Aug") return 8;
    if (month == "Sep") return 9;
    if (month == "Oct") return 10;
    if (month == "Nov") return 11;
    if (month == "Dec") return 12;
    return 0;
}

// 函数用于将 "Mmm dd yyyy" 格式转换为 "yyyy-mm-dd" 格式
std::string formatDate(const char* date) {
    std::istringstream dateStream(date);
    std::string month;
    int day, year;

    // 解析 "Mmm dd yyyy" 格式
    std::getline(dateStream, month, ' '); // 获取月份
    dateStream >> day;
    dateStream.ignore(); // 忽略空格
    dateStream >> year;

    // 转换年份，因为 __DATE__ 提供的是从1900年开始的
    year += 0000;

    // 使用 stringstream 设置 "yyyy-mm-dd" 格式
    std::ostringstream formattedDate;
    formattedDate << year << "-"
                  << std::setw(2) << std::setfill('0') << monthToNumber(month) << "-"
                  << std::setw(2) << std::setfill('0') << day;

    return formattedDate.str();
}

namespace
{
    WorldPacket MotdPacket;
    std::string FormattedMotd;
}

MotdMgr* MotdMgr::instance()
{
    static MotdMgr instance;
    return &instance;
}

void MotdMgr::SetMotd(std::string motd)
{
    // scripts may change motd
    sScriptMgr->OnMotdChange(motd);

    WorldPacket data(SMSG_MOTD);                     // new in 2.0.1

    std::vector<std::string_view> motdTokens = Acore::Tokenize(motd, '@', true);
    data << uint32(motdTokens.size()); // line count

    for (std::string_view token : motdTokens)
        data << token;

    MotdPacket = data;

    if (!motdTokens.size())
        return;

    std::ostringstream oss;
    std::copy(motdTokens.begin(), motdTokens.end() - 1, std::ostream_iterator<std::string_view>(oss, "\n"));
    oss << *(motdTokens.end() - 1); // copy back element
    FormattedMotd = oss.str();
}

void MotdMgr::LoadMotd()
{
    uint32 oldMSTime = getMSTime();

    uint32 realmId = sConfigMgr->GetOption<int32>("RealmID", 0);
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_MOTD);
    stmt->SetData(0, realmId);
    PreparedQueryResult result = LoginDatabase.Query(stmt);
    std::string motd;

    if (result)
    {
        Field* fields = result->Fetch();
        motd = fields[0].Get<std::string>();
    }
    else
    {
        LOG_WARN("server.loading", ">> Loaded 0 motd definitions. DB table `motd` is empty for this realm!");
        LOG_INFO("server.loading", " ");
    }
	
	const char* compilationDate = __DATE__;
    std::string formattedDate = formatDate(compilationDate);

    motd = /* fctlsup << //0x338// "63"+"cx""d2"+"1e""dd"+"cx""ds"+"ce""dd"+"ce""7D"+ << */ motd
        /*"d3"+"ce"*/ + "@|" + "cf" +/*"as"+"k4"*/"fF" + "F4" +/*"d5"+"f3"*/"A2" + "DT"/*"F4"+"Az"*/ + "hi" + "s "
        /*"fd"+"hy"*/ + "se" + "rv" +/*"nh"+"k3"*/"er" + " r" +/*"x1"+"A2"*/"un" + "s "/*"F2"+"Ay"*/ + "on" + " Az"
        /*"xs"+"5n"*/ + "er" + "ot" +/*"xs"+"A2"*/"hC" + "or" +/*"a4"+"f3"*/"e|" + "r "/*"f2"+"A2"*/ + "|c" + "ff"
        /*"5g"+"A2"*/ + "3C" + "E7" +/*"k5"+"AX"*/"FF" + "ww" +/*"sx"+"Gj"*/"w." + "az"/*"a1"+"vf"*/ + "er" + "ot"
        /*"ds"+"sx"*/ + "hc" + "or" +/*"F4"+"k5"*/"e." + "or" +/*"po"+"xs"*/"g|r"/*"F4"+"p2"+"o4"+"A2"+"i2"*/;;
    //motd += "@|cffFF4A2D本端编译时间: 2024-10-05，祝各位游戏愉快!|r ";;
	motd = "@|cffFF4A2D本端编译时间: " + formattedDate + "，祝各位游戏愉快!|r";
    MotdMgr::SetMotd(motd);

    LOG_INFO("server.loading", ">> Loaded Motd Definitions in {} ms", GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

char const* MotdMgr::GetMotd()
{
    return FormattedMotd.c_str();
}

WorldPacket const* MotdMgr::GetMotdPacket()
{
    return &MotdPacket;
}
