Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 064DABBF94
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 03:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503497AbfIXBKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 21:10:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43002 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388676AbfIXBKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 21:10:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so146387pls.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 18:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RuU5DS5hKVQNOmOR9I7QRwouMi4bVHIwpfJxJm3OkRA=;
        b=AywdPsONcoTFzd5M+ALTAVQ97uLpYfsaV/jDdSwr9LWXCg3PzzKUAntPuWCBMmrocK
         IGJyhs7gVtvNWPfkTch5ETh8ZyZA8eSZMi0s1Q+mcxRP5b//L7oMhAkvvLRFU7h72449
         M1NR6ynqJC+HjW0k4K1R82AX+tCii6y8ObqmEOpBaYyvUd/SRgBIptVqwIskq7VMKJ+o
         HFdRSvYsrICgYNP9/WhTKDYhNmGhPhMUarsQVhwh9uBerwp1K1kqp+iK+MpGakbFlrkP
         XvxII8Rk/3krtzcFQM7dvwWW6ZbWvJp7cCrbPALFZwv04PAwvkcV9mngTqf9pboXRZrd
         SVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RuU5DS5hKVQNOmOR9I7QRwouMi4bVHIwpfJxJm3OkRA=;
        b=SFXETujWgvrV2OHDa4mv1zhyjAsd6VzgKp08Q74JNZXno3aiYGF/h1+2ixL7pAg6Oz
         gUAOs/et2JaGrk5FHjcLJiMSxZMc+78hr2AU0HpaC2NJczRqY7z0OD8Y/1c/WBo3BzOS
         Z6M/NZYv7AVbh6HZQfEsUpk7fGBoftTQHEDgg7hPNWleVDGmxodyzsIb5X3q3kzeoCcL
         we25JeGkT+JkUt6Ykq+/twIFw6sF6EhW67dyiiGxDTYdUIKaRGM4c6BxjAV02TdpzqIm
         5qCITdsWz5XYT5kbQgniLt0MiO1PzxN7i3ooeLNMWznkf+ThWueh3OPSSMWAUjXBYEya
         bnHw==
X-Gm-Message-State: APjAAAXNovXgsyC91Jmf1mvDLiAA1EInZgv1/ad3ssE6q+sy4fzArPrP
        5U2hmSNnennTiJHXDBuJDmE=
X-Google-Smtp-Source: APXvYqx/J5YdTZCHbrM1AgxVmNN74siiz7UEiiPSiF0tBD8eSYjpGAs7onSfVbUF8zeY6X/UyW6qrg==
X-Received: by 2002:a17:902:aa08:: with SMTP id be8mr354920plb.82.1569287422748;
        Mon, 23 Sep 2019 18:10:22 -0700 (PDT)
Received: from localhost ([110.70.15.91])
        by smtp.gmail.com with ESMTPSA id e4sm108590pgn.88.2019.09.23.18.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 18:10:21 -0700 (PDT)
Date:   Tue, 24 Sep 2019 10:10:18 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Fix unnecessary returning broken pipe error from
 devkmsg_read
Message-ID: <20190924011018.GA3864@jagdpanzerIV>
References: <1568813503-420025-1-git-send-email-zhe.he@windriver.com>
 <20190923100513.GA51932@jagdpanzerIV>
 <027b2f0d-b7dc-4e76-22a7-ce80c9a0aade@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <027b2f0d-b7dc-4e76-22a7-ce80c9a0aade@windriver.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/23/19 18:45), He Zhe wrote:
> I think it is NOT necessary to inform user-space, when it just wants to read
> from the beginning of the buffer, that the buffer has changed since the time
> point when it issues the action of reading.

The point here is not to notify user space that the logbuf has changed,
but to notify user space that unseen messages are gone, we lost them,
user space will never read them.

	-ss
