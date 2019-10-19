Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAD5DD8EA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2019 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfJSOHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Oct 2019 10:07:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44172 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfJSOHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:07:08 -0400
Received: from [213.220.153.21] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iLpNn-0002CR-Jd; Sat, 19 Oct 2019 14:07:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20191018205631.248274-2-jannh@google.com>
Date:   Sat, 19 Oct 2019 16:07:02 +0200
Subject: Re: [PATCH 2/3] binder: Prevent repeated use of ->mmap() via NULL
 mapping
Cc:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
To:     "Jann Horn" <jannh@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        "Todd Kjos" <tkjos@android.com>,
        "Martijn Coenen" <maco@android.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        "Christian Brauner" <christian@brauner.io>, <jannh@google.com>
From:   "Christian Brauner" <christian.brauner@ubuntu.com>
Message-Id: <BXTK4ZPTAH1J.TZS34Z5LVHR9@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Oct 18, 2019 at 10:56 PM Jann Horn wrote:
> binder_alloc_mmap_handler() attempts to detect the use of ->mmap() on a
> binder_proc whose binder_alloc has already been initialized by checking
> whether alloc->buffer is non-zero.
>=20
> Before commit 880211667b20 ("binder: remove kernel vm_area for buffer
> space"), alloc->buffer was a kernel mapping address, which is always
> non-zero, but since that commit, it is a userspace mapping address.
>=20
> A sufficiently privileged user can map /dev/binder at NULL, tricking
> binder_alloc_mmap_handler() into assuming that the binder_proc has not be=
en
> mapped yet. This leads to memory unsafety.
> Luckily, no context on Android has such privileges, and on a typical Linu=
x
> desktop system, you need to be root to do that.
>=20
> Fix it by using the mapping size instead of the mapping address to
> distinguish the mapped case. A valid VMA can't have size zero.
>=20
> Fixes: 880211667b20 ("binder: remove kernel vm_area for buffer space")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
