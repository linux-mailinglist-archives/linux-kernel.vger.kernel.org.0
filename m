Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00618DD8CE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2019 15:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfJSNeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Oct 2019 09:34:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43927 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfJSNeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 09:34:22 -0400
Received: from [213.220.153.21] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iLos2-0000M5-QG; Sat, 19 Oct 2019 13:34:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20191018205631.248274-1-jannh@google.com>
Date:   Sat, 19 Oct 2019 15:34:14 +0200
Cc:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
To:     "Jann Horn" <jannh@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        "Todd Kjos" <tkjos@android.com>,
        "Martijn Coenen" <maco@android.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        "Christian Brauner" <christian@brauner.io>, <jannh@google.com>
From:   "Christian Brauner" <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 1/3] binder: Fix race between mmap() and
 binder_alloc_print_pages()
Message-Id: <BXTJFV9XU16K.1ARG78JWMXYE9@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Oct 18, 2019 at 10:56 PM Jann Horn wrote:
> binder_alloc_print_pages() iterates over
> alloc->pages[0..alloc->buffer_size-1] under alloc->mutex.
> binder_alloc_mmap_handler() writes alloc->pages and alloc->buffer_size
> without holding that lock, and even writes them before the last bailout
> point.
>=20
> Unfortunately we can't take the alloc->mutex in the ->mmap() handler
> because mmap_sem can be taken while alloc->mutex is held.
> So instead, we have to locklessly check whether the binder_alloc has been
> fully initialized with binder_alloc_get_vma(), like in
> binder_alloc_new_buf_locked().
>=20
> Fixes: 8ef4665aa129 ("android: binder: Add page usage in binder stats")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Ok, I see a smp_wmb() in binder_alloc_set_vma() which is called in
binder_alloc_mmap_handler() paired with a smp_rmb() in
binder_alloc_get_vma(). That makes sense to me.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
