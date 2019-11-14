Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA7DFBAE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 22:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfKMVds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 16:33:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38921 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKMVds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:33:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id l7so4097705wrp.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hi7uNnsmH2StwLwchfGQStvj4DxLSZsQRbaPkj72R20=;
        b=bQSUshpOnAJB4WbnyCLnH8YhyITjiMq7l5Ej74V5j+P8ehxNuspRAgLaBfFWTxor/T
         O0v4TxpTLdw5oSBMoI6n9Stuzs3F4RRVWKint1KGrioBoOaZlBwbyd4zATHePhWbWtF6
         PWym7WvXgIZKDnI9kxJkRUHzSIQwNgYxJOSZZeYyTkKKX/7NqAUI4gEkrxRyTof5ZHoC
         nNiiO3BHCBo8LHKgCWEAP/vcrNMOstTJHL9yswyS67f8xiaIrFGG1cVjtAQb3EOhmBet
         aZTmRpWEaLQgUL3YJtz6+5jhKjLHa2Y5S2b7QUsSQUXFORoOWNm+PU+pMBq/G5f1RcSv
         Rg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hi7uNnsmH2StwLwchfGQStvj4DxLSZsQRbaPkj72R20=;
        b=Z6VuV4g2A6/1sX54UEQvnmvUUuoZZYoP3LwV1SEN6uPsSkoCMccyvXXt1oKPN3Zng+
         0JCU2GYR4vxXTMP5fwtSgYDmqzyt40V1gjw+PkD0N1fM0GNxg8oya/DcGQwAFbudPc60
         XIwiWIrDDm7juazIKvxPT9DkpF2qkMm81m3kvKh5RYu1Fj1E3F1Kb4cBO5AQ1oDY7lpm
         AjAP/UF7dmh+HrpJd0TdLNbUaqhGxVgj+i9FSK1xO+Ek0c5UtjbxAc0dxHtspcAFBsaI
         zqkXPoC+nPI8+mpqjobp563V1Mah+MzNro0SlekBgKUJoSrVRdbSFmIPni5zB+k/WqPQ
         lCjw==
X-Gm-Message-State: APjAAAVRXNxj4rn61auHcig6HMHmu/1M9+Un0+1TQaYapRpYvlAwFDBN
        JxZYjV/ajQzvOYyP70SVxwMf8w==
X-Google-Smtp-Source: APXvYqyvQsnoN367Lb6cTTSai9R7ZFgihSeLnkf2e9LYPQ3AiDPygSK7zL6tH2kisODEZXtqH5OVng==
X-Received: by 2002:a5d:526f:: with SMTP id l15mr4742778wrc.169.1573680823040;
        Wed, 13 Nov 2019 13:33:43 -0800 (PST)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id l1sm4431496wrw.33.2019.11.13.13.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 13:33:42 -0800 (PST)
Date:   Wed, 13 Nov 2019 22:33:36 +0100
From:   Marco Elver <elver@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
Message-ID: <20191113213336.GA20665@google.com>
References: <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com>
 <Pine.LNX.4.44L0.1911121639540.1567-100000@iolanthe.rowland.org>
 <CANn89iKjWH86kChzPiVtCgVpt3GookwGk2x1YCTMeBSPpKU+Ww@mail.gmail.com>
 <20191112224441.2kxmt727qy4l4ncb@ast-mbp.dhcp.thefacebook.com>
 <CANn89iKLy-5rnGmVt-nzf6as4MvXgZzSH+BSReXZKpSTjhoWAw@mail.gmail.com>
 <CAHk-=wj_rFOPF9Sw_-h-6J93tP9qO_UOEvd-e02z9+DEDs2kLQ@mail.gmail.com>
 <CANpmjNNkbWoqckyPfhq52W4WfJWR2=rt8WXzs+WXEZzv9xxL0g@mail.gmail.com>
 <CAHk-=wg5CkOEF8DTez1Qu0XTEFw_oHhxN98bDnFqbY7HL5AB2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg5CkOEF8DTez1Qu0XTEFw_oHhxN98bDnFqbY7HL5AB2g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019, Linus Torvalds wrote:

> On Wed, Nov 13, 2019 at 7:00 AM Marco Elver <elver@google.com> wrote:
> >
> > Just to summarize the options we've had so far:
> > 1. Add a comment, and let the tool parse it somehow.
> > 2. Add attribute to variables.
> > 3. Add some new macro to use with expressions, which doesn't do
> > anything if the tool is disabled. E.g. "racy__(counter++)",
> > "lossy__(counter++);" or any suitable name.
> 
> I guess I could live with "data_race(x)" or something simple like
> that, assuming we really can just surround a whole expression with it,
> and we don't have to make a hundred different versions for the
> different cases ("racy plain assignment" vs "racy statistics update"
> vs "racy u64 addition" etc etc).
> 
> I just want the source code to be very legible, which is one of the
> problems with the ugly READ_ONCE() conversions.
> 
> Part of that "legible source code" implies no crazy double
> underscores. But a plain "data_race(x)" might not look too bad, and
> would be easy to grep for, and doesn't seem to exist in the current
> kernel as anything else.
> 
> One question is if it would be a statement expression or an actual
> expression. I think the expression would read much better, IOW you
> could do
> 
>     val = data_race(p->field);
> 
> instead of having to write it as
> 
>     data_race(val = p->field);
> 
> to really point out the race. But at the same time, maybe you need to
> surround several statements, ie
> 
>     // intentionally racy xchg because we don't care and it generates
> better code
>     data_race(a = p->field; p->field = b);
> 
> which all would work fine with a non-instrumented macro something like this:
> 
>     #define data_race(x) ({ x; })
> 
> which would hopefully give the proper syntax rules.
> 
> But that might be very very inconvenient for KCSAN, depending on how
> you annotate the thing.
> 
> So I _suspect_ that what you actually want is to do it as a statement,
> not as an expression. What's the actual underlying syntax for "ignore
> this code for thread safety checking"?

An expression works fine. The below patch would work with KCSAN, and all
your above examples work.

Re name: would it make sense to more directly convey the intent?  I.e.
"this expression can race, and it's fine that the result is approximate
if it does"?

My vote would go to something like 'smp_lossy' or 'lossy_race' -- but
don't have a strong preference, and would also be fine with 'data_race'.
Whatever is most legible.  Comments?

Thanks,
-- Marco


diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 0b6506b9dd11..4d0597f89168 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -308,6 +308,29 @@ unsigned long read_word_at_a_time(const void *addr)
 	__u.__val;					\
 })
 
+#include <linux/kcsan.h>
+
+/*
+ * smp_lossy: macro that provides a way to document the intent that an
+ * expression may be lossy or approximate on an SMP system due to data races.
+ *
+ * This macro *does not* affect normal code generation, but is a hint to tooling
+ * that it is intentional that accesses in the expression may conflict with
+ * concurrent accesses.
+ */
+#ifdef __SANITIZE_THREAD__
+#define smp_lossy(expr)                                                        \
+	({                                                                     \
+		typeof(({ expr; })) __val;                                     \
+		kcsan_nestable_atomic_begin();                                 \
+		__val = ({ expr; });                                           \
+		kcsan_nestable_atomic_end();                                   \
+		__val;                                                         \
+	})
+#else
+#define smp_lossy(expr) ({ expr; })
+#endif
+
 #endif /* __KERNEL__ */
 
 /*
