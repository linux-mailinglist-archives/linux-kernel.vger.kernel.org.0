Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0CE34E008
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 07:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfFUFX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 01:23:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfFUFX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 01:23:57 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81B07208CA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 05:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561094636;
        bh=2EBeRyKGtMJ2VCsx/+amulz5VlNO21rfW55/TIABIls=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BfXvsm3ZMFqMreFwzf/Y/mFIvYqQ0gKS6DdaChN5rbYjXjVuz0k6iR1K4HvIO1nSg
         9R8PZXDIxDTRJovxkP27+WScSyfoOULeqtwc6/QlNy8AhGWIqmNRx6osjfknRfzaub
         3eb6B7WSHGzWs77hyeREftTKY7ltG6Laj81/HW8w=
Received: by mail-wr1-f44.google.com with SMTP id x4so5199707wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 22:23:56 -0700 (PDT)
X-Gm-Message-State: APjAAAUZ8WM4g4KhFTPOS76j3sBG4oOs8aKIL32IuSIYuixdELuntk4h
        UspzaIfRkOHS2LrfiCiExyfQvFxFqw1KgeW2GD6Q0g==
X-Google-Smtp-Source: APXvYqzoWja4c3nDiSBKksnkns9RMIX6XWMOYsDRnjTIanzOX6th+BiBQ5W1AARM8CSSpdlsYrLPc3U1RxriQJo0+wY=
X-Received: by 2002:a5d:6207:: with SMTP id y7mr72377327wru.265.1561094635161;
 Thu, 20 Jun 2019 22:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com> <20190621011941.186255-2-matthewgarrett@google.com>
In-Reply-To: <20190621011941.186255-2-matthewgarrett@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 20 Jun 2019 22:23:44 -0700
X-Gmail-Original-Message-ID: <CALCETrX87W4FE1xHF_W4=Do25Ci=LJxnvxNHMs9CTOFo4988aw@mail.gmail.com>
Message-ID: <CALCETrX87W4FE1xHF_W4=Do25Ci=LJxnvxNHMs9CTOFo4988aw@mail.gmail.com>
Subject: Re: [PATCH V33 01/30] security: Support early LSMs
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     James Morris <jmorris@namei.org>, linux-security@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 6:22 PM Matthew Garrett
<matthewgarrett@google.com> wrote:
>
> The lockdown module is intended to allow for kernels to be locked down
> early in boot - sufficiently early that we don't have the ability to
> kmalloc() yet. Add support for early initialisation of some LSMs, and
> then add them to the list of names when we do full initialisation later.

I'm confused.  What does it even mean to lock down the kernel before
we're ready to run userspace code?  We can't possibly be attacked by
user code before there is any to attack us.

Am I missing something here?

--Andy
