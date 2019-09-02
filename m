Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2668AA5C1C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 20:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfIBSKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 14:10:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51875 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfIBSKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 14:10:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id k1so15480038wmi.1;
        Mon, 02 Sep 2019 11:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vDUaJApxfkNhR6vhz6RrOHesiiSeGJbPpZ0PxPybk/I=;
        b=X2KKFYMCm/kPAAybfVW+JyM12W8hl+Uuo1n8mKn/rzA7LzWsHHSQA7xH/fVkWWzDGQ
         FngagQeC/98AzdbGqqGS31CY9XrdB/EAZC4eaeudzzJ+Mp1xSqkC0QDTh1WRwnzeYsMK
         2JeNdEUWAPgUTWrG4GGn2rDlTSIv+YKvXBQcX9xoIbwkrbJgjh3AwFSWTcYDncochdG2
         6Vyi/AakJtGrUSHWxfhHbk00+qsazqOCb+6rPkDAvDQ/n3CPu3oTFPdd99lproWciZs0
         uh3UKoHaLH47LxWGCMzQN8UV9viJvdvvB3X46llQDKnaY4YX98QagxcrKXJc0buQUlfZ
         Kzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vDUaJApxfkNhR6vhz6RrOHesiiSeGJbPpZ0PxPybk/I=;
        b=fMkiy8Mks7PEzai81fFyfmob9UeXsN+LhcjS7lKsikuy6qNHuColBNgup1SlKcfqUT
         B3re5fJX+S7XEoWT8nLcQHq/f9kw7wiUZhYtq4n3DXWKCYPELCUIan7tI+woWrZHWP3m
         NlBEwSqdmJTOinWh+vTgEEc1GT5IFDmy5ZOH6AZ4pOddIdqdAsDcYBQzZnrgSKdK9NZb
         5f2NC++twiX0rUhDjXXpEq1tcqY0O1BzlbLX7BLzds9d5buqecTwbD7CFw3x4itTxn3W
         ZEPDFhifmeyglZmMrOG6B41MMA0Ssbv3XL3LUX43cH9WhdDC9GRn5CXpzNtbnE5XqYnm
         Iwtw==
X-Gm-Message-State: APjAAAVYVYn1qAJZorHNNCM+OiDaY2H78dEyWZahIhBPVeNdvFffk7Rz
        QSBcPQj6A6sByb3ct/jc9FY=
X-Google-Smtp-Source: APXvYqxO9TEqstUE7hLdlfJ+mMtY+H2+e2SfFBVFtOUhNn1MKcufFoTLuu3znyHThDv+TE/BULRZ3g==
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr12399414wmh.21.1567447813348;
        Mon, 02 Sep 2019 11:10:13 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b144sm33844070wmb.3.2019.09.02.11.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 11:10:12 -0700 (PDT)
Date:   Mon, 2 Sep 2019 20:10:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc:lock: remove reference to clever use of read-write
 lock
Message-ID: <20190902181010.GA35858@gmail.com>
References: <20190831134116.25417-1-federico.vaga@vaga.pv.it>
 <20190831084344.6fd7c039@lwn.net>
 <2216492.xyESGPMPG3@pcbe13614>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2216492.xyESGPMPG3@pcbe13614>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> On Saturday, August 31, 2019 4:43:44 PM CEST Jonathan Corbet wrote:
> > On Sat, 31 Aug 2019 15:41:16 +0200
> > 
> > Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> > >  several CPU's and you want to use spinlocks you can potentially use
> > > 
> > > -cheaper versions of the spinlocks. IFF you know that the spinlocks are
> > > +cheaper versions of the spinlocks. If you know that the spinlocks are
> > > 
> > >  never used in interrupt handlers, you can use the non-irq versions::
> > I suspect that was not actually a typo; "iff" is a way for the
> > mathematically inclined to say "if and only if".
> > 
> > jon
> 
> I learned something new today :)
> 
> I am not used to the mathematical English jargon. It make sense, but then I 
> would replace it with "If and only if": for clarity.

While it's used in a number of places and it's pretty common wording 
overall in the literature, I agree that we should probably change this in 
locking API user facing documentation.

If you change it, please do it in both places it's used.

Thanks,

	Ingo
