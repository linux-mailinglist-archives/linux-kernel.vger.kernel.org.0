Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84D29199231
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 11:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbgCaJZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 05:25:25 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:23220 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729950AbgCaJZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:25:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585646724; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=kk3gelDtGqtub3FfbL2Y4uYECNKiRmP6VyIqdrBef9Q=; b=EGDV7s8g894/MQ/vGp9KBn1bjNY6Rw3SDR9MBQYCF24hYPeBnxATD5rK80xaCwRb41QajZBy
 6bQV8QSwVFTvAAISp8dPmDhTvsHCtjJjt5Re8DUn7TYGFd+ijU4yRGtNKaL6PjrXQtC2uHfn
 5QJikL4tzS2lsGtyDKtdgO6Y0qk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e830c7c.7f323232fae8-smtp-out-n03;
 Tue, 31 Mar 2020 09:25:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8131EC43636; Tue, 31 Mar 2020 09:25:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.4] (unknown [117.98.150.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D7D8C433F2;
        Tue, 31 Mar 2020 09:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D7D8C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject:  Query : Regarding csdb barrier with llvm compiler
From:   Gaurav Kohli <gkohli@codeaurora.org>
To:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, jannh@google.com
References: <6ffd3fc0-4d9f-364b-4ab0-b90147689334@codeaurora.org>
Message-ID: <77aec890-d514-8e13-2322-55e61f587236@codeaurora.org>
Date:   Tue, 31 Mar 2020 14:55:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6ffd3fc0-4d9f-364b-4ab0-b90147689334@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<Resending again, saw some failure messages on previous mail>

Hi ,

Right now we are using array_index_nospec api in linux kernel and using 
in the place where we think speculative out of bound access may happen.

This thing is applicable with GCC tool chain, as for GCC we have to use 
builtin api to place csdb in the required places.

Recently llvm toolchain comes with hardening option which will place 
csdb in the required places, Do we have any plan to use this thing in 
linux kernel.

Regards
Gaurav

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
