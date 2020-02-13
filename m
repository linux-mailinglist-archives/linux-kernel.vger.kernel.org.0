Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5247915BDB0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 12:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbgBMLem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 06:34:42 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41717 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMLel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:34:41 -0500
Received: by mail-qk1-f196.google.com with SMTP id d11so5279075qko.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 03:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VSt973hv/QfrpDHXWJ8G2UOF9Wa/lnfW+Pjf23P9P30=;
        b=sjO1AgGuqroNntfZVFrbHRsfQarPG/RNkbx884jvzfti4wftqKRRIHCv/yHRkBPAts
         8lCtQSvZWMLPioSiqRhHCf3/o4TCiC4OXSz7nQ9lUV0L3qbfZ7UjfKfR1zIdYqqXSFgk
         LpQ/bzDjwLamYL8z58X8rc+wtaW5xw92tKQl2sAP070YbTxBnFoYfn5L54PK6UsazPZp
         b1tlMb1rEySTkuauZDZVcGaH8ZKcEXEuKLX/d9ItbThwkcVImGz8LHbV4CviIqEdEuwL
         YDJYyLueKGD7NjwVFCok0H2/sOp+b5pqQIL13lUyIpHX9sh1Mlr2tPtrs87oPkga6mB1
         Fx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VSt973hv/QfrpDHXWJ8G2UOF9Wa/lnfW+Pjf23P9P30=;
        b=qBK9VPF1XNddzZxUr5ZmcdQL2javbtAE2FwphAlwnaudv94qvmXVsiffz6ExI0ILSm
         Dr6pn1+7hXH+a0HciMziHuIcgEWw1cxp40flXQ5uP5excuGW28+lwz1OH8X56iVxbLlu
         A6oJJg/9kWx0l6gJVuztyeDeM+qJp4GcspVJdFIvpQZKGTOhp1QTWJD3BMTKcM7XYwBW
         tPnjWF3jmcLkldJuKMdGGzPU3VZNCQGEJd8r4SUujySyQArVJWmhHn7raVpU9JuopWPW
         2VFdxPD7FQRlSGgCyAj0jlGjtwmJ206hOdHMsxjRBBgBnHsK0H8iMeHdHv+YNnTR7VJu
         HRKg==
X-Gm-Message-State: APjAAAXyLGzobJRx74KBvHJbmt5yw9EwF6+sE9l/RgyLTuVmpYTHBIDm
        m+jCGujQmE0Jn254ry+qKWU=
X-Google-Smtp-Source: APXvYqz5vvB+WVrDlPoO5rukeQ63p4hoxhct3LGLyZkXmynEjEMPZqNdUR3LbapTyEwBGcwItYOzSw==
X-Received: by 2002:a37:4894:: with SMTP id v142mr11135684qka.220.1581593679345;
        Thu, 13 Feb 2020 03:34:39 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id g6sm1139614qki.100.2020.02.13.03.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 03:34:38 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5FD29220BD;
        Thu, 13 Feb 2020 06:34:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 13 Feb 2020 06:34:36 -0500
X-ME-Sender: <xms:SjRFXmB_lU7g0hJPMLN6JkK06D4G3hHTqw7Mwvuzkr5Fm2PkxczMVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieekgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucffohhmrghinh
    epghhithhhuhgsrdgtohhmnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvsh
    hmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheeh
    vddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:SjRFXsh5T1MI4-0LegWeTaWNddW2pFop7YHOWIQc73yR1lSinfytxw>
    <xmx:SjRFXrzaYxdE6PMfvEKzsx8sMr3rgVeRgYlGS9FoehV53W31do13cA>
    <xmx:SjRFXl3qDIxlN3IIEgvQiKZoWvSq-chriOws0KrdTQoHvZnNoRLplQ>
    <xmx:TDRFXuNhsS43D-8YM0imxLMnfJQHV6rnlyrk6oxPJpnuNc18WEsXKw>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0E73F30600DC;
        Thu, 13 Feb 2020 06:34:33 -0500 (EST)
Date:   Thu, 13 Feb 2020 19:34:32 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        arnd@arndb.de,
        Stefan Asserhall load and store 
        <stefan.asserhall@xilinx.com>, Will Deacon <will@kernel.org>,
        paulmck@kernel.org
Subject: Re: [PATCH 7/7] microblaze: Do atomic operations by using exclusive
 ops
Message-ID: <20200213113432.GF69108@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <ba3047649af07dadecf1a52e7d815db8f068eb24.1581522136.git.michal.simek@xilinx.com>
 <20200212155500.GB14973@hirez.programming.kicks-ass.net>
 <4b46b33e-14ad-7097-f0db-2915ac772f15@xilinx.com>
 <20200213085849.GL14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213085849.GL14897@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 09:58:49AM +0100, Peter Zijlstra wrote:
[...]
> 
> > Also is there any testsuite I should run to verify all these atomics
> > operations? That would really help but I haven't seen any tool (but also
> > didn't try hard to find it out).
> 
> Will, Paul; can't this LKMM thing generate kernel modules to run? And do

The herd toolset does have something called klitmus:

"an experimental tool, similar to litmus7 that runs kernel memory model
tests as kernel modules."

I think Andrea knows more about how to use it.

> we have a 'nice' collection of litmus tests that cover atomic_t ?
> 

There is a few in Paul's litmus repo:

	https://github.com/paulmckrcu/litmus/tree/master/manual/atomic

Maybe a good start?

Regards,
Boqun

> The one in atomic_t.txt should cover this one at least.
