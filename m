Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4EB76B61
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 16:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfGZOVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 10:21:20 -0400
Received: from sonic304-21.consmr.mail.ne1.yahoo.com ([66.163.191.147]:32927
        "EHLO sonic304-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725869AbfGZOVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564150878; bh=OZTYvFC+2DETo5lwYO6MFnQgLTQokLFP37Hfdjk2lm0=; h=Date:From:Reply-To:Subject:From:Subject; b=lhUM6pZ24Za7PZN2TWoyccuN9N+NDaHmyLEVxP5f2mzjFurA7AeVnF7j9Szn6oJttjnHdoz8x7I6CZ9QqjjPHaQI9uXxEh+Z5pzrImGXG3Bbdgh0qZE0muRbdCafS7wObs3P7EyHBNhOItKpKAFXlm6m36QA0CWjD78MP6ekCgxmnBmjBXrAvpOnkH5aibiPa8Tc/VTBIpqCegVtyqXI2Yq9cr2doRunZhuSHF9q9H1g6Tqhpub1QqWXuepVYd//sjNANVk3LcCEBALsR8TSGaPG21JJ5AqrD+0m2vO8JfoEs3MJy08hC6vPba5I+1g10NKl5SIvEs3UkxUZ1VUQWw==
X-YMail-OSG: 5B0u.agVM1mZZNPr__lE6N_X4ZGyZ6PDS4TJntXim7__HuSCowhnrJPdaCJQUhQ
 UA1jNUyD8GdCAE0Zz9FG1XdAZGbzGUkIk44kdE0fCSVyMMXhNqTjyg2VgQlinJl2mAZ8S7A_c_Qg
 0R0TQ38daR2veyd7IqST_kWxKI_ErKq6Cc9k3Pucpf5NKNPVTeiPZ6eucx_em5mVGaGEjECdDG5I
 8Z52JzDldsZokJGvJ7qtdn18xQ8zzQZsCFg1QzoEUe6hR6yFCeiSMW42wYphVzKkPl6XqHr4S7QI
 c81Xu0Uzz3knV8jJa.mHLN4lUH0K58q9iFXjVBxkYgtJr5ltFLid74v0oYCHR.WvgMLSNgLt7HZJ
 wLpu7.LvIYhxrjzQgy32fZjBr_KaZ8tSsBJzr1jpsTSCgN8Y2l.c8utQD1PLBxZDm_4e0Mv.AnfO
 x03QxrrX2dc7DAOSxEngw5n3Sccp05K3..ihCAL0GDoFfMfkF4OmlsBnwwRjDn.K4HiJU3leKyvP
 oPHc4kOQ65Oklb9Fec2CIZkcm0chJCXvROkHfGR0jxITBjpA8fBDsBXwujfYGVIN3a8pZryjEYne
 Lr_tE79WrTAgX7DL1V6ATERHL3bjMJP_qN_U3f.7Ui4ycyEa7bzNPCtJgD2iPgMKjSbJfzltoj4c
 0jYkQyIYTsimglKuMXD17Bp0SIhaF_7GLc81FN1sKfIz4BMJdrBx7gNsBzsaVNV6M5exNJwKTZTB
 R1TqjuePnKEXmJHSFQj7IV.ddZOBTch83ewy8AqTMLKXNEuOuVHgg4RMeADKVdGVBcYS8eFTyR47
 R4f.jn69ayKZxg_M5oxfT8diEChTETersWgSMVMDTt1uVMb9BTOXwU1oR_sImLoTM1z.3e1YwYud
 .BzElC3uRNlhrOAX4QvatenKfddNA6IATOtGmpAIVEwJU_LZm81qmVhX_xKVTIoM0PxAyfLAH8Kw
 bgWtb8stbcqDRfg8qQt2s_msoKP0jzpbVuDAfOEHXCeS4na3XR4CA6JKy4QdObc6iIhe79ku2tZG
 N2dLGaJNzhvWKwsnJF4B_YbjtfeEO_o.YvUVjXRl.KpCyowBQGTb2bCXcaWwubI18tbtOjgpeCo2
 jMdDF3QRZV.igzVQ.M.QA2Y6BRwM.JkuSidpXqSf.tR9eXnviRr67R5Qas1mJu_778Ndi0KAmzaP
 jg7OvQcu1.EDXYXuybH1MnNjMZ11.4qh25znS.cu9l3oXJlLxwYDbng--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Fri, 26 Jul 2019 14:21:18 +0000
Date:   Fri, 26 Jul 2019 14:21:14 +0000 (UTC)
From:   Miss Aysha Al-Gaddafi <missayshaal0@gmail.com>
Reply-To: missayshaal0@gmail.com
Message-ID: <1167228374.2040166.1564150874695@mail.yahoo.com>
Subject: ASSALAMU ALAIKUM
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkFTU0FMQU1VIEFMQUlLVU0sDQoNCkkgaGF2ZSBhIGJ1c2luZXNzIFByb3Bvc2FsIGZvciB5
b3UgYW5kIEkgbmVlZCBtdXR1YWwgcmVzcGVjdCwgdHJ1c3QsDQpob25lc3R5LCB0cmFuc3BhcmVu
Y3ksIGFkZXF1YXRlIHN1cHBvcnQgYW5kIGFzc2lzdGFuY2UsIEhvcGUgdG8gaGVhcg0KZnJvbSB5
b3UgZm9yIG1vcmUgZGV0YWlscy4NCg0KV2FybWVzdCByZWdhcmRzDQpNcnMgQWlzaGEgR2FkZGFm
aQ0KDQrYp9mE2LPZhNin2YUg2LnZhNmK2YPZhdiMDQoNCtmE2K/ZiiDYp9mC2KrYsdin2K0g2LnZ
hdmEINmE2YMg2YjYo9it2KrYp9isINil2YTZiSDYp9mE2KfYrdiq2LHYp9mFINin2YTZhdiq2KjY
p9iv2YQg2YjYp9mE2KvZgtipINmI2KfZhNi12K/ZgiDZiNin2YTYtNmB2KfZgdmK2KkNCtmI2KfZ
hNiv2LnZhSDYp9mE2YPYp9mB2Yog2YjYp9mE2YXYs9in2LnYr9ipINiMINmI2YbYo9mF2YQg2KPZ
hiDZhtiz2YXYuSDZhdmG2YMg2YTZhdiy2YrYryDZhdmGINin2YTYqtmB2KfYtdmK2YQuDQoNCtij
2K3YsSDYp9mE2KrYrdmK2KfYqg0K2KfZhNiz2YrYr9ipINi52KfYpti02Kkg2KfZhNmC2LDYp9mB
2Yo=
