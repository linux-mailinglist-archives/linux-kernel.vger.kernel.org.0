Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE2AD6AA59
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 16:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbfGPOLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 10:11:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46997 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfGPOLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 10:11:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id c73so9169333pfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7plrCe7cNTS0+Z/xokDsw3l+fNtSeqJL0Jrh4WZePeU=;
        b=IQjAYIFlhWgS2pmAEDWTEk6uDc/BgtT1FAtmk9N5fRCu1YTn8bGTXAeI7TXX+SW7gs
         Fvm3uTrVcyNHEBvYpeUWzmPV+fpDZmlqnkNLAMFrQDC4VpEfSkuAv6iyBcm6baW3N66O
         mcRWK9r/mHsg54EOgJIf7ACPPGIX+g9aoo2NFadFdxquBggUSFe7ZRUtqhDsGUs6PAF5
         CGbdNCLmirCF4r+w/AXsswWE9fXsuIx3piexaXKy7Qw6hu3xv1RzPtOF2OxicW3LJOON
         UQm2SSAPGgNN+dKOqpl5ry/6RiUrqu/YhelSbUrql9zR2W+iFxrd+4kBLmcpteFTfAS6
         pncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7plrCe7cNTS0+Z/xokDsw3l+fNtSeqJL0Jrh4WZePeU=;
        b=qPMWW2QRuEjP783QVdGXcrvplvzB1nRTSrnl+6nTZdl+tX7sk0fxCCgiIaJKwKPO/u
         GPuNqI/misNSr2lOFWVnLXRabDia4GyF2FmRwJj8rnGSHrypk/Fem9+mdC/i6+wAhYH+
         xY2krHUA53yxkovSxzx7RDT47tvMU9OHwzSLNzxzCTTBJ7Z72FPSbXt+lrbMSsgxQAbK
         +9MLfF5+tynzzh1GJL8H4gv2Obh/89MYNpscpUjCSj7LP5gFC6D5K0b4kIo3UCD6WgXH
         xwtpRcjmPZWgXFBuX5MHU9MbksNiOVPaLBDx3qoGGHpjLWHI0B2lCL1zafrpnENF8At9
         DwaA==
X-Gm-Message-State: APjAAAX2oq/KIazrdChTHew13N7WFbPi8YRtdEXOycwxO4Hr24I1QsGn
        gkLO+EMd1p4McCcOEU6nROc=
X-Google-Smtp-Source: APXvYqxWonvROtYZuFnyeiQD93daARvUGt8q3WqJQ8VqbqRis3eCqaIjCof04P1rEfOgx0NZ/bVz3w==
X-Received: by 2002:a63:2f44:: with SMTP id v65mr33469693pgv.185.1563286312858;
        Tue, 16 Jul 2019 07:11:52 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id t7sm10699361pfh.101.2019.07.16.07.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:11:51 -0700 (PDT)
Subject: Re: [PATCH BUGFIX IMPROVEMENT V2 0/1] block, bfq: eliminate latency
 regression with fast drives
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name
References: <20190715105719.20353-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6867cf11-d7f8-cadf-b9ec-85549bb86af3@kernel.dk>
Date:   Tue, 16 Jul 2019 08:11:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715105719.20353-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/19 4:57 AM, Paolo Valente wrote:
> [V2 that should apply cleanly on current HEAD]
> 
> Hi Jens,
> I've spotted a regression on a fast SSD: a loss of I/O-latency control
> with interactive tasks (such as the application start up I usually
> test). Details in the commit.
> 
> I do hope that, after proper review, this commit makes it for 5.3.

If it's a regression, it should have a Fixes: line telling us which
commit originally introduced the regression. This is important for
folks doing backports. Can you add that?

-- 
Jens Axboe

