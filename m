Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE177B5FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 11:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfIRJLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 05:11:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34189 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfIRJLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:11:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so3675170pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 02:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6uvS0UZ6H/zDo06Y5m/KUvTD9XX9l52PqJXfvtuw9xA=;
        b=Rq/d9Do/vXMKTUN8PzO+7daKezpcMdb+iT3YDE/xO0xQi6g4o+VugW6g+fV1Kq2X0B
         ZgddWfj4B1snpD3KlnFQtSqrRkZG4QdlWt5W24clVUTPk+2Ot49LLGEeyMk7XSq4756Z
         /5/6AN8l5Vuu+ENLg1Mal2K+3mVSXsrn7DAmy3jeVx0R0Tx/pt9stNqzop2gOFbEteiu
         2elnrgs1vdKGhLfks+f2UOgLUvMWKSSOTMTbYbVi9Cb4RL5w7R2xZUvXeWxjkNlA/FSu
         LbLNKGts7oZkyzYaT20zHc5XLqviPDSCpIVUrDXLGZsgvg2F5e0ikjvTwkbycidm7YmE
         AuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6uvS0UZ6H/zDo06Y5m/KUvTD9XX9l52PqJXfvtuw9xA=;
        b=sK4VZ5gNlhZNHLzT9KvxbwwFN3SjwxGIpGUzfDYMrNyL3QPMrVHAk6FiW5pMbomcFv
         eQuGDgRffvLoiMs3NjZT2mIq2xcej41bcgoxKvocwN9TjhTWxxo01DZklj5S2MHCOdWG
         772p0rxxw7qGLUB9OwWM+qJeGYeyIWMOnM4oZ1cdZmq1b0yGze0GdfVTlmDsxoB2+6hc
         xjL7uwfnYc8T01wpgk5gkPvvGL0o9GJ5oGrZQRhH+UyT1qn0wP/pSl6Qhm5RhQGHQ4rv
         TpQCPFNtYkzL6ieWm+5+Vq88PMxecsIySDMrdEavdEvMfgxfYuwuIjQ2/f+WRkeTC24g
         lKlA==
X-Gm-Message-State: APjAAAUrdpIxCgDcvvfnu9JF+Eun3zN7PYj75sLL8uWjM77Iw0VieyJg
        S0pTgSidMdD8H+4ZqYliIso=
X-Google-Smtp-Source: APXvYqwAOJDM8xwsbkbeHIRmCEaj63zG1exnj6TSDu7k/r8474gxLnDnS3r/INCJ43qGMUY1DIRNMg==
X-Received: by 2002:a63:5222:: with SMTP id g34mr2777904pgb.405.1568797864898;
        Wed, 18 Sep 2019 02:11:04 -0700 (PDT)
Received: from localhost ([175.223.34.14])
        by smtp.gmail.com with ESMTPSA id 62sm5946596pfg.164.2019.09.18.02.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 02:11:04 -0700 (PDT)
Date:   Wed, 18 Sep 2019 18:11:00 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Paul Turner <pjt@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: printk meeting at LPC
Message-ID: <20190918091100.GA55364@jagdpanzerIV>
References: <20190905121101.60c78422@oasis.local.home>
 <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
 <87k1acz5rx.fsf@linutronix.de>
 <20190918012546.GA12090@jagdpanzerIV>
 <20190917220849.17a1226a@oasis.local.home>
 <20190918023654.GB15380@jagdpanzerIV>
 <20190918051933.GA220683@jagdpanzerIV>
 <87h85anj85.fsf@linutronix.de>
 <20190918081012.GB37041@jagdpanzerIV>
 <877e66nfdz.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877e66nfdz.fsf@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/18/19 11:05), John Ogness wrote:
> On 2019-09-18, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> >> Each console has its own iterator. This iterators will need to
> >> advance, regardless if the message was printed via write() or
> >> write_atomic().
> >
> > Great.
> >
> > ->atomic_write() path will make sure that kthread is parked or will
> > those compete for uart port?
> 
> A cpu-lock (probably per-console) will be used to synchronize the
> two. Unlike my RFCv1, we want to keep the cpu-lock out of the console
> drivers and we want it to be less aggressive (using trylock's instead of
> spinning).

That's my expectation as well. cpu-lock and per-console kthread can
live just fine in printk.c file.

	-ss
