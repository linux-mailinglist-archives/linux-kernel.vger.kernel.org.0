Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 484D0C8F47
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 19:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfJBRD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 13:03:57 -0400
Received: from excelsior.roeckx.be ([195.234.45.115]:47097 "EHLO
        excelsior.roeckx.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbfJBRDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:03:55 -0400
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Oct 2019 13:03:55 EDT
Received: from intrepid.roeckx.be (localhost [127.0.0.1])
        by excelsior.roeckx.be (Postfix) with ESMTP id C5ECCA8A0291;
        Wed,  2 Oct 2019 16:55:37 +0000 (UTC)
Received: by intrepid.roeckx.be (Postfix, from userid 1000)
        id AC1F61FE0C11; Wed,  2 Oct 2019 18:55:34 +0200 (CEST)
Date:   Wed, 2 Oct 2019 18:55:33 +0200
From:   Kurt Roeckx <kurt@roeckx.be>
To:     linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>
Subject: Stop breaking the CSRNG
Message-ID: <20191002165533.GA18282@roeckx.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As OpenSSL, we want cryptograhic secure random numbers. Before
getrandom(), Linux never provided a good API for that, both
/dev/random and /dev/urandom have problems. getrandom() fixed
that, so we switched to it were available.

It was possible to combine /dev/random and /dev/urandom, and get
something that worked properly. You could call select() on
/dev/random and know that both were initialized when it returned.
But then select() started returning before /dev/random was
initialized, so that if you switch to /dev/urnadom, it's still
uninitialized.

A solution for that was that you could instead read 1 byte from
/dev/random, and then switch to /dev/urandom. But that also stopped
working, /dev/urandom can still be uninitialized when you can read from
/dev/random. So there no longer is a way to wait for /dev/urandom
to be initialized.

As a result of that, we now refuse to use /dev/urandom on recent
kernels, and require to use of getrandom(). (To make this work with
older userspace, this means we need to import all the different
__NR_getrandom defines, and do the system call ourself.)

But it seems people are now thinking about breaking getrandom() too,
to let it return data when it's not initialized by default. Please
don't.

If you think such a mode is useful for some applications, let them set
a flag, instead of the reverse.


Kurt

