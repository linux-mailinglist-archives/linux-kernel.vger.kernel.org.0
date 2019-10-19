Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCF2DD8DE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2019 15:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfJSNzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Oct 2019 09:55:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44104 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfJSNzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 09:55:24 -0400
Received: from [213.220.153.21] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iLpCR-0001Xa-Hw; Sat, 19 Oct 2019 13:55:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20191018205631.248274-3-jannh@google.com>
Date:   Sat, 19 Oct 2019 15:55:18 +0200
From:   "Christian Brauner" <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 3/3] binder: Handle start==NULL in
 binder_update_page_range()
Cc:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
To:     "Jann Horn" <jannh@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        "Todd Kjos" <tkjos@android.com>,
        "Martijn Coenen" <maco@android.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        "Christian Brauner" <christian@brauner.io>, <jannh@google.com>
Message-Id: <BXTJW0B3Y8RD.1TSRR5G3JNB20@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Oct 18, 2019 at 10:56 PM Jann Horn wrote:
> The old loop wouldn't stop when reaching `start` if `start=3D=3DNULL`, in=
stead
> continuing backwards to index -1 and crashing.
>=20
> Luckily you need to be highly privileged to map things at NULL, so it's n=
ot
> a big problem.
>=20
> Fix it by adjusting the loop so that the loop variable is always in bound=
s.
>=20
> This patch is deliberately minimal to simplify backporting, but IMO this
> function could use a refactor. The jump labels in the second loop body ar=
e
> horrible (the error gotos should be jumping to free_range instead), and
> both loops would look nicer if they just iterated upwards through indices=
.
> And the up_read()+mmput() shouldn't be duplicated like that.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
