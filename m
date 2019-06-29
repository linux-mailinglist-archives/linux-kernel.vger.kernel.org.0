Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03F345AD42
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2019 22:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfF2UAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jun 2019 16:00:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35334 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfF2UAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 16:00:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id c27so1933855wrb.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7gve1XIB6qFihzoZrREZMHuH1w3Xvh8/V0xsajTSO+c=;
        b=JpQ0mJH2q9tRnA02USH96/beGiuQl3I+41zd6THZnJWI/zuwew2jikeCJ2WBkkZ6sQ
         nbZKoxDzMtPEo/tHsQdToEQKSnhu/ek534VfHxI7gzxOHEcII8jDVqOorp0Q5e2Ux+Ob
         65wHnOuN7Iae/ym/hYG/J6OnJxtgTo8ykPkLCyRY1EDzGyir0lmOsq44Y1EUdUpGJYMy
         +8PINFU8WXtEtBt4FACFqh5haknKfTpdI0NDiB5sgL4oXYAGVgXeN+TT2dyKXl0SxBct
         c1guPK+Hd4XUdUMUf1sHsAgxerlu4aLMGK4CKis0aEM+zxyZ5dLO3gYykjwfr8u63u1L
         odFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7gve1XIB6qFihzoZrREZMHuH1w3Xvh8/V0xsajTSO+c=;
        b=PG3y26Wt+U+3k9OSp1/I6HKcUMrKraTrNlL9myA2mzq0Cu3rS1+xlnCejAfXKgQNB+
         MCJrXUNCTQXPzJstI+Ec+r0hGtJ0BMybWlSY8A+vBXf9G0kZGF4TcCukYmm/bxj5wja9
         zlo9vntABG0q9dbS1p/HS+b4HmpnEcK2njzUNdEnzBk4YqxPxYW+byrLO+UdWSR4q8XC
         rtraJu2HBqds6J7vd6bPmXCRmmH1TZhJpbC7xjylrVFx8dFEMy1iUz/2Oi5VSnhFDMzK
         iP3d2iE7/x8Z7NfBGz0DxTxTBy8LKit7k7eOoZ3twMnvk3rlSCCZH7R5urS69perO6Ip
         fo4Q==
X-Gm-Message-State: APjAAAUf8mAs4bQZa+t88EDDxipS1KdNNy0PE4YxmuXMqFzOzAAZ9KSI
        FS13VS4C++9h2iC8X3RSJ1E=
X-Google-Smtp-Source: APXvYqxWQzCxWoh4UjsqoRFazhiQ+rRBIV5iCURq0qMW20Azj5/MqCWawsKwcS9xOU98NnGaHtb32Q==
X-Received: by 2002:a5d:518c:: with SMTP id k12mr12673759wrv.322.1561838398655;
        Sat, 29 Jun 2019 12:59:58 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h14sm6346245wrs.66.2019.06.29.12.59.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 12:59:58 -0700 (PDT)
Date:   Sat, 29 Jun 2019 21:59:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] smp/urgent fixes
Message-ID: <20190629195956.GA581@gmail.com>
References: <20190629194535.GA79708@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629194535.GA79708@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Linus,
> 
> Please pull the latest smp-urgent-for-linus git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-for-linus
> 
>    # HEAD: 33d4a5a7a5b4d02915d765064b2319e90a11cbde cpu/hotplug: Fix out-of-bounds read when setting fail state
> 
> Two fixes:
> 
>  - Fix an out of bounds access when writing nonsensical values to 
>    /sys/devices/system/cpu/cpuX/hotplug/fail
> 
>  - Warn about unsupported mitigations= parameters.

Linus, please ignore this duplicate pull request. I thought Thomas didn't 
send this one yet, but he has a few hours ago but the Cc: to me was buggy 
so I didn't notice it at first. :-/

Thanks,

	Ingo
