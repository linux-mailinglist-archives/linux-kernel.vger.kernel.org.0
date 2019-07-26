Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE35275EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 08:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfGZG0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 02:26:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58238 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfGZG0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 02:26:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 744C960734; Fri, 26 Jul 2019 06:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564122367;
        bh=EbZ8V/DEcs0/4znrzggpjMRyIZLsE99CLDSEHMkEF4I=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=ILMJwpgxOLX2eMtgJTBQuce8DNgvDGeX8Fpm10eLZD/HdmUS6W7P5UmYjWbBn+lB5
         9x5adW3YYsZJNHhwCWsJoGNXroy9T3LjqHvpYuXQBCOMl04rizdTfcfLwl6zaV+1lE
         zPPL4WGu+uPtys7m3XY8alF5gSFavlvz8jUpNWxc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.79.136.27] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A593F6053D;
        Fri, 26 Jul 2019 06:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564122366;
        bh=EbZ8V/DEcs0/4znrzggpjMRyIZLsE99CLDSEHMkEF4I=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=YVML3e72rFVZFteKr7KSCTHnPOEip/doe8dq52LfuNF0h09sTjHTNdY8LRGHJr5du
         IpC5CaBa1tdz1E27R+2F5JPQCn14DLCYEfJ5Pcuk+ltSTL/tIfGwj5CPyrzMDiil2W
         +1iCSORfJnl6EKLMKJuw5+TZU6va8B3Z60s68SpI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A593F6053D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [Regression] Missing device nodes for ETR, ETF and STM after
 CONFIG_UEVENT_HELPER=n
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cfe09a46-462f-633a-37c2-52f8bfc0ffb2@codeaurora.org>
Message-ID: <e3a01f7e-9662-415d-1e3d-df3734d3e305@codeaurora.org>
Date:   Fri, 26 Jul 2019 11:56:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cfe09a46-462f-633a-37c2-52f8bfc0ffb2@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/2019 11:49 AM, Sai Prakash Ranjan wrote:
> Hi,
> 
> When trying to test my coresight patches, I found that etr,etf and stm 
> device nodes are missing from /dev.
> 
> Bisection gives this as the bad commit.
> 
> 1be01d4a57142ded23bdb9e0c8d9369e693b26cc is the first bad commit
> commit 1be01d4a57142ded23bdb9e0c8d9369e693b26cc
> Author: Geert Uytterhoeven <geert+renesas@glider.be>
> Date:   Thu Mar 14 12:13:50 2019 +0100
> 
>      driver: base: Disable CONFIG_UEVENT_HELPER by default
> 
>      Since commit 7934779a69f1184f ("Driver-Core: disable /sbin/hotplug by
>      default"), the help text for the /sbin/hotplug fork-bomb says
>      "This should not be used today [...] creates a high system load, or
>      [...] out-of-memory situations during bootup".  The rationale for this
>      was that no recent mainstream system used this anymore (in 2010!).
> 
>      A few years later, the complete uevent helper support was made 
> optional
>      in commit 86d56134f1b67d0c ("kobject: Make support for uevent_helper
>      optional.").  However, if was still left enabled by default, to 
> support
>      ancient userland.
> 
>      Time passed by, and nothing should use this anymore, so it can be
>      disabled by default.
> 
>      Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
>   drivers/base/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> 
FYI, I am testing on linux-next.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
