Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A57AE1307BF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jan 2020 12:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgAELff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 06:35:35 -0500
Received: from mail-40130.protonmail.ch ([185.70.40.130]:63219 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgAELff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 06:35:35 -0500
Date:   Sun, 05 Jan 2020 11:35:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1578224132;
        bh=BNZKaN4bN9fZXS45LfHyW3evvah/rkZdt/3vKSl+bKc=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=uH4Dfcqn6h6WPeJ7ovrXaAI5AKiIZDqzSGLpoNuJ2BxJ11AkGX96HT+/tvn3RpwxZ
         uW5ujEirn7mXnZDgJxE0JfZgfyeJe+TE/27LFlnTd8JjliMpeKzpaY1gzmVwwu3rdn
         x/rEPQJQDPMkCMG4NC8+q2yEp2QuMPDSOyAhPMIw=
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
From:   atmgnd <atmgnd@protonmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Reply-To: atmgnd <atmgnd@protonmail.com>
Subject: Re: [PATCH] usb: missing parentheses in USE_NEW_SCHEME
Message-ID: <RCWksfFWQHlnigRaJXhtDAVRhJyOLVg8X0quHP9R6YiddyTUkLWt00rhYgDrmGXxTmR_1T3BFfAf-uIh1Iwhe-GTkT-0RDfbN64ePPiqNY4=@protonmail.com>
In-Reply-To: <20200105081721.GC1667342@kroah.com>
References: <ht4mtag8ZP-HKEhD0KkJhcFnVlOFV8N8eNjJVRD9pDkkLUNhmEo8_cL_sl7xy9mdajdH-T8J3TFQsjvoYQT61NFjQXy469Ed_BbBw_x4S1E=@protonmail.com>
 <20200104114603.GB1288021@kroah.com>
 <HdXgMrky4rCGyM4q7eTsrfOB4yGZRUNwV9YSXBPh98r2UZeFzREQj35K60r-8Lf9LYVgVuKCcmQ2l7ihAD9DoqAdluQrA3zbQrF03VtNC-0=@protonmail.com>
 <20200105081721.GC1667342@kroah.com>
Feedback-ID: py-oVO8Vt0vS1FKaKugS2_MTpFC3lKhHMurhoXPAalWk9Eh40Mo1lZOn2CI1vswSSKJBwBLYgn_VKFu9qW3csg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_REPLYTO
        shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have already resend you a new patch with 'Signed-off-by: Qi Zhou <atmgnd@=
protonmail.com>', Can you just use that one ? thanks.


Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Sunday, January 5, 2020 4:17 PM, gregkh@linuxfoundation.org <gregkh@linu=
xfoundation.org> wrote:

> On Sun, Jan 05, 2020 at 01:15:41AM +0000, atmgnd wrote:
>
> > Is that ok ? Ordinarily I dont use protonmail, only because outlook mai=
l is blocked by kernel email system.
> > So I register this email to send plain/text emails.
> > I will resend it.
>
> Just add a "From:" line in the first line of the changelog text to match
> up with your "real" email address. The kernel and git documentation
> should show this.
>
> thanks,
>
> greg k-h


