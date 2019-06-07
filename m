Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6207739385
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 19:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbfFGRn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 13:43:26 -0400
Received: from smtp2-4.goneo.de ([85.220.129.36]:55093 "EHLO smtp2-4.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728684AbfFGRn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:43:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 589D023F6F6;
        Fri,  7 Jun 2019 19:43:23 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.818
X-Spam-Level: 
X-Spam-Status: No, score=-2.818 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=0.082, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D8uN15LMcBEP; Fri,  7 Jun 2019 19:43:22 +0200 (CEST)
Received: from [192.168.1.127] (dyndsl-091-096-214-241.ewe-ip-backbone.de [91.96.214.241])
        by smtp2.goneo.de (Postfix) with ESMTPSA id 13FE923F6EE;
        Fri,  7 Jun 2019 19:43:22 +0200 (CEST)
Subject: Re: [PATCH] linux: README: reduced README size by 1 byte by removing
 unnecessary space character
To:     Alex <awaitingvictory@gmail.com>, paulmck@linux.vnet.ibm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, Aaron A Montoya <aaron.a.montoya@gmail.com>
References: <20190607055917.17040-1-awaitingvictory@gmail.com>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <d210b4ec-eacf-b521-9e9b-e3d61a70a5fa@darmarit.de>
Date:   Fri, 7 Jun 2019 19:43:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607055917.17040-1-awaitingvictory@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 07.06.19 um 07:59 schrieb Alex:
> From: Aaron A Montoya <aaron.a.montoya@gmail.com>
> 
> On line 9 of the README there is an unnecessary extra space character,
> after the period, that adds 1 byte of size to the file. By removing the
> unnecessary space, Linux downloads will be 1 byte smaller and therefor be
> faster to download and take up less space on a user's system, all while
> correcting a sentence structure issue. This change is one of the few
> optimizations with practically no downsides, besides taking time out
> of the hardworking Linux maintainers day to implement the change.
> Remove extra space after the period on line 9 of the README.
> Commit 0619770a02a30834 ("Removed unnecessary space character from README")
> 

best joke today but wrong in two ways ;)

1. size matter? The commit (-message) adds to more bytes to the repo ;)
2. Be correct formated?  The extra Space is for 'sentence spacing' [1]
    e.g. emacs text modes are formating such spacing.

[1] https://en.wikipedia.org/wiki/Sentence_spacing

-- Markus --
