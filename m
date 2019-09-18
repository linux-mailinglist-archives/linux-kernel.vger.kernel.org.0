Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDE1B609B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 11:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfIRJpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 05:45:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36834 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfIRJo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:44:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so6182586wrd.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 02:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eCLILMrB8mD8WH5ZI56Ui1as0kflIkZo+f5drYOqODU=;
        b=jnwvM/JCe7dQxy7Jt7t2lIaLS1sxq4bmGQbRrF201NU4Bd1fyk7F5kyeEg/DDLMaVR
         Z7tgAHpqjlAYtdALkNpqwcEci9O2JtbFAJz22s2EiLpirMpvNYuX88N1xQGTMENZqOtf
         aVoORxLEdmpJqpqC896kQg3oPyoW215I4/KEu6e2XVx8U4FF83j1m7Abq0mwgglBaPJT
         VqEA5b0x44lhvuH61nOFBLQ4+FWiuftqr6Ixgiwf/VQPQ4KbSqNckrcMShtD2b0+i8FW
         Wmmhp33aTs2VFu10vThZ984O2okOenV4/PuX+BcNoCWYIp8ZoZT1Qrlaf6Ntzo2bT8D6
         N0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eCLILMrB8mD8WH5ZI56Ui1as0kflIkZo+f5drYOqODU=;
        b=RoT9eO+KnWjW+kMegio8JEsxg/VetvBR14AcUF7Gbwa7uiuWw5dpotZVBfyXLsJ6Qq
         o6g8cQNAUXkAxPP6pBe5vkZsT6PFUO7wsTlW5a9cHs2icAsKQxZvchkmum7Wzg1LrDkb
         JXcfSj1DXwyilqBN8O9FlxT5PRLMqcHs7owEx/CRi/Y0iY10V37Wzjgz/V1Brvv3aWq3
         Bt4xZP4B9X2DCQrYp/CM1S4ObppmTKQ4MSc6/TEJZmfY3sgQMZCKEoaNQVGvlioLZIiU
         bnnFR0lae7idjQFieXS2jlv/BYLsNfpsJOxpNTHg6cLTQFd8unrSJhk2b8KBPnItNC5g
         0nzw==
X-Gm-Message-State: APjAAAXVaUulsJXvkZ60uKPuMyewgjGsbo2j5p3sfEKon0jyZRepDlqj
        voStS7Bis2r+EzYEjdBUJ2ws+TYfW2I=
X-Google-Smtp-Source: APXvYqwL1vvLlHf+fFasKN8fEXWfnu/p1xv2EtDJE7z4Lp9yim6eYktJPsrPXov8PON1BslCWJPD7w==
X-Received: by 2002:a5d:6885:: with SMTP id h5mr2372166wru.92.1568799896895;
        Wed, 18 Sep 2019 02:44:56 -0700 (PDT)
Received: from ?IPv6:2a01:e35:8b63:dc30:80ea:482c:5423:216b? ([2a01:e35:8b63:dc30:80ea:482c:5423:216b])
        by smtp.gmail.com with ESMTPSA id v64sm2266331wmf.12.2019.09.18.02.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 02:44:56 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] net: sysctl: cleanup net_sysctl_init error exit paths
To:     "George G. Davis" <george_davis@mentor.com>,
        David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1558020189-16843-1-git-send-email-george_davis@mentor.com>
 <20190516.142744.1107545161556108780.davem@davemloft.net>
 <20190517144345.GA16926@mam-gdavis-lt> <20190708224732.GA8009@mam-gdavis-lt>
 <20190917155354.GA15686@mam-gdavis-lt>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <14606764-a026-c171-ba71-bf242a930e7e@6wind.com>
Date:   Wed, 18 Sep 2019 11:44:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917155354.GA15686@mam-gdavis-lt>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 17/09/2019 à 17:53, George G. Davis a écrit :
[snip]
> Ping, "Linux 5.3" kernel has been released [1] and it appears that the
> 5.4 merge window is open. The patch [2] remains unchanged since my initial
> post. Please consider applying it.

net-next is closed:
http://vger.kernel.org/~davem/net-next.html

You will have to resend the patch when net-next opens.
