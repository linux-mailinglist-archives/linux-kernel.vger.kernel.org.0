Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7206787B95
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 15:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406550AbfHINnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 09:43:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44195 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfHINnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:43:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so98280866wrf.11;
        Fri, 09 Aug 2019 06:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SVXw2/bA5C08+BykjuTS3dhz6TKyxWMjOdIKpXnFiF0=;
        b=TcFa53Pe6w905vM1bqYF+nLYo8tQrTgJIrxxnpRw/rxcr/2qaSe82JgI1DQHu/qAu8
         VzcYmYfaN/c4oA20PLjIdbl8BxAtrBDuri/cT6GPeC5BI+8dkmku2QLrZ5r04Ven0BHX
         ZiExBDuyFNxcsa6XkWzGHV5i5Lz3DZLoEjMjC8NdtMtawGcnSgbNmMKD7VmWWDgI/4Ei
         kar3LbVj01LhCiJcUsQVHy7eo8YaYe6KL73Mh1MAGKVpk0jZrBy1QmuPVVXE4zLOO/uj
         wyyn3K2KJGLEA+taNPtBy83suO6qqtb6rZi+pII/Sifi1YNKnwpKaD4fF8Ntq1KFgWxh
         Djuw==
X-Gm-Message-State: APjAAAUjgl40HQRK71Rw/b4FShS95oErkBSeWXYOsJeSq1jAqzZBZ5r4
        nSXDtPEFxZFKy1kcLjwoxJo=
X-Google-Smtp-Source: APXvYqzgfODOd8I82ICcOo3N3RU4p19HM2GuesacfNF1Br8xggXKcJZpItkDTk8yUNwJ/N/88Pfi3Q==
X-Received: by 2002:a5d:460a:: with SMTP id t10mr23215213wrq.83.1565358230117;
        Fri, 09 Aug 2019 06:43:50 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id z1sm98784974wrp.51.2019.08.09.06.43.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 06:43:49 -0700 (PDT)
Subject: Re: [PATCH] floppy: fix usercopy direction
To:     Jens Axboe <axboe@kernel.dk>, alex.popov@linux.com,
        Jann Horn <jannh@google.com>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Mukesh Ojha <mojha@codeaurora.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr
References: <20190326220348.61172-1-jannh@google.com>
 <9ced7a06-5048-ad1a-3428-c8f943f7469c@linux.com>
 <b324719d-4cb4-89c9-ed00-2e0cd85ee375@kernel.dk>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <b509abcf-224b-7bfd-a792-dd8579dbcca9@linux.com>
Date:   Fri, 9 Aug 2019 16:43:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b324719d-4cb4-89c9-ed00-2e0cd85ee375@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> So I add a new floppy maintainer Denis Efremov to CC.
> 
> Looks like it got lost indeed, I will just apply this one directly for
> 5.4.
> 

Thank you!

Denis
