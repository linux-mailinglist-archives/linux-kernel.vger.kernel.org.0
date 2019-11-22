Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 144EF10780E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 20:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfKVTeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 14:34:16 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45233 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKVTeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:34:16 -0500
Received: by mail-pg1-f194.google.com with SMTP id k1so3762188pgg.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 11:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oqYSA8zPdRhtM6rEbGD4qCmkL4I7wr9gbLC8ZneJKVc=;
        b=EzoKUoESpP7irV8mjBMQGFbkhw9eSthUJ77TIPPGKtB23+8EqQ0cWzVuPUeosoGWqE
         BAQk5RERzYiIArk0/gBzoYWGUcA/9jZxOZJSsVP8MjqTzDR6lzz3lO5HXM/cpFkqUBxx
         rvqxmTYM0BPsOvg4nLtdGolSZddlBz+VEkbSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oqYSA8zPdRhtM6rEbGD4qCmkL4I7wr9gbLC8ZneJKVc=;
        b=lI1KkmTmJwz9Xi4876grHRFi8ucRk2k99tLWVnvprgYUOLZT1ryJ5tuK9IPSxsBEZP
         D+hA9p6RYftIbpLNhoVOc3v7wWDxcVfg+oitUlojvb/A7hnMKDl3dq0ykA0E2CImorzQ
         +KimW+vi6lGTBfziWsXu/Bs2OZLgJWe5Hrh9sZzc6qentGgYCZvbATtJlq1h6k2acT5n
         yTlG5WPBqD5RmdHwfZvoDf/twtx8Du0Dmmc1zMPuQ3rDmpVLoAE2YxQo8NLk29kgSiv8
         KOBL/1wMA6QO4b66e7WmVX1m90xdtdD40qx9/n4ivjoFlpgb+hS+Ala6+dFgjcXRnAjA
         Ss7Q==
X-Gm-Message-State: APjAAAU7QMlFNGCZV6HDFkJdQT/a4zZvcCRHGWSvJ6BbDwbCbeGSJSYB
        JPmieKTXpZZPN2riV9ncp+ZTZA==
X-Google-Smtp-Source: APXvYqyCwXryEcLfjsz9Ez7xd3217ZlZjgNnnO5Wwz4cArL7b6i2ioPLdFCp6e+EEo30hlTjCqNnLQ==
X-Received: by 2002:a63:4415:: with SMTP id r21mr18033144pga.184.1574451254140;
        Fri, 22 Nov 2019 11:34:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i26sm8292006pfr.151.2019.11.22.11.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 11:34:13 -0800 (PST)
Date:   Fri, 22 Nov 2019 11:34:11 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Replace bio_check_ro()'s WARN_ON()
Message-ID: <201911221131.A34DFAA49@keescook>
References: <20180824211535.GA22251@beast>
 <201911221052.0FDE1A1@keescook>
 <20191122190707.GA2136@infradead.org>
 <94976fb5-12d3-557d-7f31-347d6116b18c@kernel.dk>
 <20191122191434.GA10150@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122191434.GA10150@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 11:14:34AM -0800, Christoph Hellwig wrote:
> On Fri, Nov 22, 2019 at 12:09:14PM -0700, Jens Axboe wrote:
> > On 11/22/19 12:07 PM, Christoph Hellwig wrote:
> > > On Fri, Nov 22, 2019 at 10:53:22AM -0800, Kees Cook wrote:
> > >> Friendly ping! I keep tripping over this. Can this please get applied so
> > >> we can silence syzbot and avoid needless WARNs? :)
> > > 
> > > What call stack reaches this?  Upper layers should never submit a write
> > > bio on a read-only queue, and we need to fix that in the upper layer.
> > 
> > It's an fsync, the trace is here:
> > 
> > https://syzkaller.appspot.com/x/log.txt?x=159503d2e00000
> 
> Oh.  I think this is a bug in the block layer, we should not treat
> a sync as write for the purposes of is read-only checks, as it never
> writes data to the device.  At the request layer we alread use
> the proper REQ_OP_FLUSH, but at the bio layer we are still abusing
> empty writes apparently.  I'll try to cook up something over the
> weekend.

Cool; thanks! Note that syzbot has a reproducer for it:
https://syzkaller.appspot.com/text?tag=ReproC&x=117ccc8c400000

If that doesn't work for your own testing, you can ask syzbot to test
patches itself:
https://goo.gl/tpsmEJ#testing-patches

-- 
Kees Cook
