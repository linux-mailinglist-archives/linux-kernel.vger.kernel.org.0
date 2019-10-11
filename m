Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEF47D39F4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 09:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfJKHVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 03:21:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59820 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfJKHVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 03:21:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0AA2060C5F; Fri, 11 Oct 2019 07:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570778502;
        bh=WkQrvk5nZdbFlR7R6nIX7hBotfoCIQXVHQx/7ibG+Uc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lDvSnwYrIDpMwOC1dG+D7dKfTFjt4HUFqdy7v0GOjQybddKJrXPkYfcptPJ2F9EGT
         kousywg6H4M4cSAHsRfQHUhVptCR7D5l3roLnmFOVoccVFHBXjPt6rxEgUNek1dUMu
         zgLTaO/SbUXLszDRm0Pbh0c7joigBCaM0Xe9A2Lc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9EB9560A0A;
        Fri, 11 Oct 2019 07:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570778500;
        bh=WkQrvk5nZdbFlR7R6nIX7hBotfoCIQXVHQx/7ibG+Uc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dmYotePOOzEE6Acy+6MZY5GC2SxDWsJXr7LdEdyJryauUT/oeMqwiddodTivQBFLr
         E5BUtt3EJxR/jgp2cbbUBcI7e6vWTr68IK35nPuBW5JyBAWX0IjiN12ayUK2SwUp/8
         ZrJADS6C5m1q7h9YW3UwSM65PmnPxlJOIcElI33w=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Oct 2019 12:51:40 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Harish Bandi <c-hbandi@codeaurora.org>
Cc:     Claire Chang <tientzu@chromium.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjliao@codeaurora.org,
        rongchi@codeaurora.org, linux-bluetooth-owner@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_qca: fix in-band sleep enablement
In-Reply-To: <238f01ec4b49fee4c0d08a0b8da7e95f@codeaurora.org>
References: <20191009085116.199922-1-tientzu@chromium.org>
 <238f01ec4b49fee4c0d08a0b8da7e95f@codeaurora.org>
Message-ID: <74740c0ff64a6a658da2a44a9f9b7ac5@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claire,

This change will not work  as we need fw files to be loaded tofor IBS to 
active.
may i know on which chipset you have this issue of IBS active even with 
out fw download.

On 2019-10-11 12:31, Harish Bandi wrote:
> ++ Balakrishna
> 
> On 2019-10-09 14:21, Claire Chang wrote:
>> Enabling in-band sleep when there is no patch/nvm-config found and
>> bluetooth is running with the original fw/config.
>> 
>> Fixes: ba8f35979002 ("Bluetooth: hci_qca: Avoid setup failure on
>> missing rampatch")
>> Fixes: 7dc5fe0814c3 ("Bluetooth: hci_qca: Avoid missing rampatch
>> failure with userspace fw loader")
>> Signed-off-by: Claire Chang <tientzu@chromium.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index e3164c200eac..367eef893a11 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1291,10 +1291,8 @@ static int qca_setup(struct hci_uart *hu)
>>  	/* Setup patch / NVM configurations */
>>  	ret = qca_uart_setup(hdev, qca_baudrate, soc_type, soc_ver,
>>  			firmware_name);
>> -	if (!ret) {
>> -		set_bit(QCA_IBS_ENABLED, &qca->flags);
>> -		qca_debugfs_init(hdev);
>> -	} else if (ret == -ENOENT) {
>> +
>> +	if (ret == -ENOENT) {
>>  		/* No patch/nvm-config found, run with original fw/config */
>>  		ret = 0;
>>  	} else if (ret == -EAGAIN) {
>> @@ -1305,6 +1303,11 @@ static int qca_setup(struct hci_uart *hu)
>>  		ret = 0;
>>  	}
>> 
>> +	if (!ret) {
>> +		set_bit(QCA_IBS_ENABLED, &qca->flags);
>> +		qca_debugfs_init(hdev);
>> +	}
>> +
>>  	/* Setup bdaddr */
>>  	if (qca_is_wcn399x(soc_type))
>>  		hu->hdev->set_bdaddr = qca_set_bdaddr;

-- 
Regards
Balakrishna.
