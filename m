Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2875D688CA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 14:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbfGOMPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 08:15:53 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:33059 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbfGOMPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:15:53 -0400
Received: from [192.168.1.110] ([95.118.111.244]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mate1-1iKwry29lL-00cQf8; Mon, 15 Jul 2019 14:15:45 +0200
Subject: Re: [PATCH 1/3] platform/x86/pcengines-apuv2: add mpcie reset gpio
 export
To:     Florian Eckert <fe@dev.tdt.de>, Eckert.Florian@googlemail.com,
        info@metux.net, dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190704090205.19400-1-fe@dev.tdt.de>
 <20190704090205.19400-2-fe@dev.tdt.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <3e98bbd8-c051-4996-fc5a-88a58a2fa2d4@metux.net>
Date:   Mon, 15 Jul 2019 14:15:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190704090205.19400-2-fe@dev.tdt.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:S2oNFKep22pqWXKixHD14ji3HNkueaIFIPSI83rcVj1+S575yXx
 AC3CMH/pQUf5GRoNq54vEe+p33e0Ob9sTeHWErNpQ00hZ01xwz1Kdu+PcBJuXGyQH5/udbG
 cP+KNWQ4u4zaxALeI+jP0rkrESDWWEK7ZDxH93VzxqjndLpwNmXH6SbTY9ldvwHwoPGTliI
 wamzl4qtERO/eomhnQkJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WP1wYsAWbI4=:Sbgx3DDxBqoDDN9KJtXCPH
 9c16Rj1sEH0FyLE16ELaKu9Prc0HMeGx3YjLSR03ZKvbFO5MFrmml1HfIMiGU15Q1U9yWzZP0
 ZF8v9MJA1NxK1YrZS46IQ/9hJhSr/XWp4JHaBKIq/yb0r568eacpOLqISX3Oe/M7EbVMrjRVM
 CtRX3BBGMQPyCqCKi0OYukzhu8h+KpJipMe694r++old0z+jxF+8Nub9Cst9Oa4g5HFIi5TEa
 yCElbmsYhNhpXbgGxXx5/VK6kPmB/s573mD/lwMsinfBIKwNETdNXUOWjB5qd7MDH6qx+gQxo
 n0dUE5XkyUJUgeLUcfoncvzeBN+XptN/BSMTC+w2P7srUxNwOcWKHLQWc+yRt0HmAZx3kwocA
 rslPltB7jzO3jiCvEUSceweeh2siIWzdVWh1ZPq8QU/ZKq8u2po55LGSct75pycq2tY8K7TWF
 QVwi1HP1fb8p7nCmSXBIp1NzL3590ln/v2nugxpr+vRYzx0WvSf99tOx7+tl5x7kQ0mLfGSEK
 Ddem8fUMWvPxr+CYvVYdWS8pLvGGEPkIQup344Ynhbp7gyltTSZy7wXpa3iA9tN9vh3o1e06W
 mmgmmiA0CGF0zqVsxrdKDfM2LVQyEGi7tv+GQMFFKKGbWzmP+tXpqd8skwRj4zoMhGp1kGZbF
 PBdSb3DhUK7U62pWy1aDm8NEWNPMmGemPVl2+UvPtm3pSCFABiCFgX52mlckW/7wrlKraPZa5
 vq70SsDBxoqrL0fgYj9RE1HQQacdZcO4JJx+ycDf0xLYR6XG2pOVSEIoLkw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.07.19 11:02, Florian Eckert wrote:
> On APUx we have also mpcie2/mpcie3 reset pins. To make it possible to reset
> the ports from the userspace, add the definition to this platform
> device. The gpio can then be exported by the legancy gpio subsystem to
> toggle the mpcie reset pin.
>

Just tested your patch on an apu3. The driver itself seems to work,
but the pins don't seem to actually do anything.

How exactly did you test it ? Do you have some test case ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
