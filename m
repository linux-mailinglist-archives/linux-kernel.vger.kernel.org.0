Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB88C63F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 05:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfGJDEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 23:04:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42735 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGJDEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 23:04:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id t132so447711pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 20:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FEdkSOwEiVwsjukTZwCe45mSNh9wLOeBdBVL8WohUzo=;
        b=Z0YbjvDiU4Dl9aNipT1ktogMqPG2Og0ttfZsdv410DnOxzNF2klf3krXd6sI3jSnkA
         OorwPv0xLSJNKN2os3jrd5Mh1vp6nX6A+ncnNXJPdvzGNqXBR6rcq2FOkx0s9qtky0LL
         Sl28apdMmUiKwIzj7P2vdfGiUcnVvkpy2M4N8dV5qk7IBBuuOEAATxl6W5oqse0EoSDT
         yHBvobmIIQixUrLModsm2nBtKItEVWiJvpwLOSbadKGLlT0G1fbBr+qxtZTfwPzAA3Xc
         clmt+kE5syBrDCsEFGbBwmYb8pnGkKW2wXEjh5v8dNxG9g8w1+GKqN2QsBkuD7bcvOf0
         Kwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FEdkSOwEiVwsjukTZwCe45mSNh9wLOeBdBVL8WohUzo=;
        b=FO8MymJHLHkR1nCYGouabCR6r50zKL9jeUkX7/m6mA1d5P/YoHsUlV3YfGAxPZFFcb
         4XisJDeKA2ueJwLl5y/ZvgUJg/eVh20Opx6iK3NPw2uqh5gamlfflZfJ00Qkz+///Soz
         yV3TIxAZqXlmt1zVMmOh2RHHbEkwp+ijXJEsmuazjyEjuxrYnnGS9/RBhvn2r1A9j3lP
         0+OamtUXfu3OHV3eYu1CtsbgVRB+BROqctl9PbwWzFz1AqF0m69/gOTOI8geNxeEHkK3
         7nHHQF47W624yFeytj2jsL6uhQtxcFSg4X+x5hltaIzgdut6BD5TH8g/FbNeD03SIbeQ
         cBmQ==
X-Gm-Message-State: APjAAAWFR5t8TINKA8EgZQKaUJTJD2lOwM3Lct+BLI04AZSKw3tpUopw
        pK4ApA/2kRKbWszphE5y6z3vMA==
X-Google-Smtp-Source: APXvYqzBhnFM7SlKJzm2GX+T7m0tRfqvvbkxi8I6ixZaRzF6nvLCIjP6+yJ6bPrXj6oDdjdOB6JdXQ==
X-Received: by 2002:a17:90a:17c4:: with SMTP id q62mr4059609pja.104.1562727853159;
        Tue, 09 Jul 2019 20:04:13 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id z13sm396715pjn.32.2019.07.09.20.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 20:04:12 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] ata: make qc_prep return an int
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20190709100203.19049-1-jslaby@suse.cz>
 <20190709100203.19049-2-jslaby@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ed428e5-8108-e6c5-b580-9dd20ec049f0@kernel.dk>
Date:   Tue, 9 Jul 2019 21:04:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709100203.19049-2-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/19 4:02 AM, Jiri Slaby wrote:
> In case a driver wants to return an error. sata_mv is one of those --
> see the next patch.

Not against the change as such, but there seems to be some confusion on
int vs enum ata_completion_errors. The latter is probably poorly named
if you're going to start using it for prep return, but would probably
still be saner to have an AC_ERR_OK as 0 and use that and use the enum.

-- 
Jens Axboe

