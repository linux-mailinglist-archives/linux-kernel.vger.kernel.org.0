Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF0109B78
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 10:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfKZJqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 04:46:00 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:33126 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfKZJqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 04:46:00 -0500
Received: by mail-wr1-f46.google.com with SMTP id w9so21663784wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 01:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k+BtnFSMnRjQ8YYOOPZrpiqvm9HWBxF1S878IBj12ug=;
        b=GXz3qg5o/QW/Dmv9EU/db6tEE79XUdmiFmDrBxtau+F/+RnojIXwdWorI81FlNzv6G
         D0xJxWFa6EN4/TsCWOwCuhAaVPrvAsUPEWPA/3q/5Py1zBsxao+9XXI+YInvyjMvhG81
         NSc0AIGbAfQ7XLF9OVx5RBJaqd9nHDtEMyG/uhaHF77Vg3xzLqKRcmltbpNp5ku/QEOo
         EevUmZP0FYnKvolWMrmER/SMKblWjQwRrNaMTGiR6g/aBqiPPKHo5MRY5rdgLtkvidjC
         JQQzxQ5cc8YzyeO6LJl92lX2Xt92ES+DQoBAUPv1a0taEG1UrVsSIzMoRO87kpW/awFn
         gczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=k+BtnFSMnRjQ8YYOOPZrpiqvm9HWBxF1S878IBj12ug=;
        b=MZg4wgWXLGJxdedzrqdJCZWj4sAYIK7AX7A+Jmk0BEwZaMhqAfxkbpl7PagrIlWljn
         Yaqzw6lkYFTbZx+5KBZTrtZdFvVzJCum+oFGBFi1bmc/znEBcUm330J+fq6HKsxhZhlh
         8VwwwQG16cajY0hLXk+sPxj/Hqktokl+duaTprKghNQ/SztqZU10N3AxeCUPQo+UhREr
         AiMj/ZuPzPef9iJplAmUWaqFbuPi8A2IGWwxdRoHrLTneGrTql8VF5WKfN9pk6q0vpUD
         3Lcz7Q1ojXkaIYlEAdQTNzH1BYxFeyrNVxAUO9CqflC5k1gm+j5VNP3oTqtU47oq8hEV
         C27Q==
X-Gm-Message-State: APjAAAUEgVhJi7ys23MgU464sd4La9eEf+XDkntcEjOH8rQN2KtZCCga
        bAPcrGT0rlnvEOQ3vV0IQL8=
X-Google-Smtp-Source: APXvYqxybMjr5GimfVXDM2FP+7xc7awNx2xcyYveS80RNO/cxOLZM/moc97qpoTatLU3PLiUYHjfiQ==
X-Received: by 2002:a5d:5546:: with SMTP id g6mr14255018wrw.320.1574761556918;
        Tue, 26 Nov 2019 01:45:56 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id b17sm14408420wrp.49.2019.11.26.01.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 01:45:56 -0800 (PST)
Date:   Tue, 26 Nov 2019 10:45:54 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [GIT PULL] x86/iopl changes for v5.5
Message-ID: <20191126094554.GA3017@gmail.com>
References: <20191125161626.GA956@gmail.com>
 <20191125192456.GA46001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125192456.GA46001@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Forgot to list the conflicts that may arise if you merge this after the 
> other x86 bits.
> 
> Firstly the symbol bits would conflict here:
> 
>             arch/x86/entry/entry_32.S
>             arch/x86/kernel/head_32.S
>             arch/x86/xen/xen-asm_32.S

Note that these conflicts will arise once you merge x86-asm-for-linus, 
with an additional semantic conflict in arch/x86/crypto/blake2s-core.S, 
see my merge conflict mail to that pull request.

> There's also a conflict in arch/x86/include/asm/pgtable_32_types.h.

This asm/pgtable_32_types.h conflict will be the only conflict you'll see 
when you merge x86-iopl-for-linus:

  <<<<<<< HEAD
  #define CPU_ENTRY_AREA_PAGES    (NR_CPUS * 39)
  =======
  #define CPU_ENTRY_AREA_PAGES    (NR_CPUS * 41)
  >>>>>>> e3cb0c7102f04c83bf1a7cb1d052e92749310b46

And the correct resolution is to pick the '41' side.

Thanks,

	Ingo
