Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B82131361
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 15:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgAFOMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 09:12:01 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39183 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgAFOMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:12:00 -0500
Received: by mail-pj1-f66.google.com with SMTP id t101so7839291pjb.4;
        Mon, 06 Jan 2020 06:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x12/MnWhTR1CIEE0fQm8ZPt2JEPyxFhF/62AyMWTIF4=;
        b=RpSlUCiajdnrEkAiBHB/x1FRMzdTfV3a1ys+JWRpm7WbTS6bAlo0YmhyVcNdZJvzlZ
         xP1st+plEabEOlJVceM+gXmG0k+6tdFXNh0hFz2u16soAiPqjp7UZsIHfVJITb6QMvgx
         ohRP6Picahxw4T/kNf3vDvhnwArV/r7/iCZQkHkJ1C6ukeKj8b40SB7GMggCeaQeMghV
         PgjMKK2v/xUw1Lqv/YGd1zLlvXF8K8VuiXPwOZ5hKBftK6HSUd2bBqCf4iiGq64+kkIn
         fbaPhrZsnr2O/nEadsoDQUekyA5O46jLdPID9sLBXSMtJccMaTyWTOSuQXmA5FedvtBV
         nPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x12/MnWhTR1CIEE0fQm8ZPt2JEPyxFhF/62AyMWTIF4=;
        b=d460oLkqalQ7pU/LZBmVtFf7PbIl/+mjQTywp051hpIGHwodvsrurx5hk3RXfF3Swu
         CUI3vzYmk9AOAKzSB6W6SL9kk9x5eHjVkIP9kmB7hs0lJNEBsKnz55TG4CfcZsBkdfMq
         V7zOLkNiOinE4hTACrtXNFmu876doDKr7PzwJXXyg2kKC9SZ3J3BlN8SP/6GW/oKe6Cm
         9jzKHSCG3u3RSv3quiDOPjFvePfzBFYY5xT2bG39LOMLgN9134s1LFs2jqGlAbC6bLp8
         060xG40jHhrdTKB0j6KAm1yXe8aLUkFLRce29K0BiyybQPRoplTrMPKly9Avc3Z3pBBn
         /erQ==
X-Gm-Message-State: APjAAAWFmwx9hyV5aRHVcFv9rLdzY0N5iTF9CImpvZwblRAdPHyleRBr
        73CvgGmPLw2cSa7GEm82rUPSy6rd
X-Google-Smtp-Source: APXvYqxrt0zTD1KBEl/X2X7mwqWt77TT4QOMIp4Un+U4TMoV3QwtgBa6Rz5uEGVSXKT+enUqThUung==
X-Received: by 2002:a17:902:d711:: with SMTP id w17mr107885064ply.303.1578319919767;
        Mon, 06 Jan 2020 06:11:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p23sm73759456pgh.83.2020.01.06.06.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 06:11:58 -0800 (PST)
Subject: Re: [PATCH][next] usb: typec: ucsi: fix spelling mistake "connetor"
 -> "connector"
To:     Colin King <colin.king@canonical.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ajay Gupta <ajayg@nvidia.com>, linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200106111124.28100-1-colin.king@canonical.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <99d45a1f-69f3-083b-35bd-7e09eea4d64f@roeck-us.net>
Date:   Mon, 6 Jan 2020 06:11:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106111124.28100-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/20 3:11 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_dbg message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/ucsi/ucsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 466bd8afceea..1b1e36178317 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -669,7 +669,7 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num)
>   	struct ucsi_connector *con = &ucsi->connector[num - 1];
>   
>   	if (!(ucsi->ntfy & UCSI_ENABLE_NTFY_CONNECTOR_CHANGE)) {
> -		dev_dbg(ucsi->dev, "Bogus connetor change event\n");
> +		dev_dbg(ucsi->dev, "Bogus connector change event\n");
>   		return;
>   	}
>   
> 

