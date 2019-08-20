Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00683962D7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 16:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfHTOr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 10:47:57 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:62167 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbfHTOr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:47:56 -0400
Date:   Tue, 20 Aug 2019 14:47:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1566312473;
        bh=B7GDbManiUylcf7u2LfPNfUCNUXLjlWjiI1tiFVGZ2w=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=vY+iuLbrB4M/H3McBmkntvglUgExAv0GmjeCy/+ZvVvcWj4CiZxWk1QNpGNxRCKjv
         rs3cqgy4SNMrwz1QopJmN4r1000RzWOwScILPo6XWn87aP6yVWzmHvVm7aSudcLVtd
         GXLBykhP0voWRpa1IBulMhWEZgQ0M0oGn79ttWWQ=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Cosmin Marin <marin.cosmin@protonmail.com>
Reply-To: Cosmin Marin <marin.cosmin@protonmail.com>
Subject: using eventfd between userspace and kernelspace
Message-ID: <yDn_z_4GHfSpIzdE7eDKtLqbCz4BJzNUZlJrz1Jy6Mo_4DpsxWOMvOATbxVZWctK7zbAkq_gNk-G6mTZ42QiFRT-4ULUtK-A1LUlUqdu0qo=@protonmail.com>
Feedback-ID: B3-Ymcvw__4SJIdrFAhRVroPcNoOjV-D-_9wumY_cvu35QlUYy_IovVHdim3y4cXXYsh27K_OQHNDdh_PCbMJQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I have some doubts regarding the usage of eventfd and I'm seeking for some =
advice/suggestions. I want to use eventfd in a producer-consumer manner (EF=
D_SEMAPHORE) between a process's userspace and a kernel module.

The desired behaviour: periodically, a userspace thread writes to the event=
fd=C2=A0while some kernel tasks (under the context of other userspace threa=
ds) read from it. When the eventfd reaches 0, the readers will block waitin=
g for the producer. The consumers will always terminate at producer's comma=
nd via an IOCTL.

Now, I have the following doubts:
1) Older versions of Kernel provided a way to read=C2=A0(eventfd_ctx_read) =
an eventfd from the kernel but that's no longer available; the counterpart =
for write (eventfd_signal) it's still there, though.
What I am looking for is a portable way between different versions=C2=A0 to=
 read an eventfd from kernel. One option is to get a pointer to the "file" =
structure based on the "fd" and call the corresponding read function (f =3D=
 fget(fd); f->f_op->read()).

Does anybody see a problem with directly calling f_op->read() ? Obviously, =
another option would be to reintroduce eventfd_ctx_read.

2) I also need the semantics to be slightly different: I want to be able to=
 reset the eventfd's counter every so often instead of adding to/incrementi=
ng the current eventfd value; that is, I need a write() to set the counter =
to a specific value.=C2=A0In my view some ways for the implementation are e=
ither to add a new flag (EFD_COUNTER_SET) that would work together with EFD=
_SEMAPHORE or a dedicated IOCTL for this purpose.

Any other suggestions/comments ? Would something like that be accepted in u=
pstream ?

Cosmin

Sent with ProtonMail Secure Email.
