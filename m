Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B02A1168B4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 09:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfLII4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 03:56:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40569 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLII4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 03:56:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so13941709wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 00:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+jNs0/gfWc0O18Xh8VftNsf/QHjT78loeH1CleZ5apQ=;
        b=pRkgVlld4RpsLZhMXn+Stf+sKQddTBZbNnDPk62zOvKGmPwUrmusOxoAp0us7YJXou
         ys+A3qkN3UOG8+Vkg+5gvBRWfVjmA0LdGAiAiLD9h2Us1HXp0wmOeHGKMtUp/uloYTAg
         j7ai0IF/7T5g84Pi+9rhE1kdqG/7aQyUnJaTyLhMz9eONuFxjUd017zn1qamKDrSDJOB
         3osWQXmE3lo71ozoxwMEGxc2Pdlb2MiZD3fEtuQqSmztQV1SAR1nvJZKE0uriUGv6clK
         2fb8o9mC/gedn8Wqc2qlFOpm+Rit19CnDE2ijWhZXtzma0OA9baDv2/SkTLIjQGDIUv7
         StGg==
X-Gm-Message-State: APjAAAU+7pJR4yiHaGFwZzuVq8Q/GDDxnfKTvpA+Phadu+Ig2N3VeCMK
        YMOVLbF7cJWNbstsXdeaeVs=
X-Google-Smtp-Source: APXvYqxo+DeuQmn77r793oTfIMPyj1gOkRciRJ2kiEAoJSe20gejEmrTaA5i0JLrOD95ryH6oX0EnQ==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr15043958wmc.36.1575881760547;
        Mon, 09 Dec 2019 00:56:00 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id a184sm13283420wmf.29.2019.12.09.00.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 00:55:59 -0800 (PST)
Date:   Mon, 9 Dec 2019 09:55:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     David Howells <dhowells@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Subject: Re: [pipe] 3c0edea9b2:  lmbench3.PIPE.bandwidth.MB/sec -17.0%
 regression
Message-ID: <20191209085559.GA5868@dhcp22.suse.cz>
References: <20191208153949.GJ32275@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191208153949.GJ32275@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 08-12-19 23:39:49, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -17.0% regression of lmbench3.PIPE.bandwidth.MB/sec due to commit:
> 
> 
> commit: 3c0edea9b29f9be6c093f236f762202b30ac9431 ("pipe: Remove sync on wake_ups")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Huh. How can something like that can even can get merged? No changelog,
no s-o-b?
-- 
Michal Hocko
SUSE Labs
