Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764B313054A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jan 2020 02:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgAEBPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 20:15:45 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:21218 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgAEBPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 20:15:45 -0500
Date:   Sun, 05 Jan 2020 01:15:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1578186943;
        bh=FLqA5vba7vBCWbF+5gAGqL7jH6p7ymdbLBgT0LChQY0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=IA0uwnxauqq0fckfDpiDRVNiChTJ2U7KI++dze46IG8t+oazNlD8sGt0gMxGhqH5A
         ogzldcCG5DVB18itaFSir9INwhk4NLLSW9LV2oKZjsmcKaxy4mXgV5tFiXXGKkg26r
         nxKctBeiLVSrS1Mf5pd3DVPEFTac1+0IAKgR/NiU=
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
From:   atmgnd <atmgnd@protonmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Reply-To: atmgnd <atmgnd@protonmail.com>
Subject: Re: [PATCH] usb: missing parentheses in USE_NEW_SCHEME
Message-ID: <HdXgMrky4rCGyM4q7eTsrfOB4yGZRUNwV9YSXBPh98r2UZeFzREQj35K60r-8Lf9LYVgVuKCcmQ2l7ihAD9DoqAdluQrA3zbQrF03VtNC-0=@protonmail.com>
In-Reply-To: <20200104114603.GB1288021@kroah.com>
References: <ht4mtag8ZP-HKEhD0KkJhcFnVlOFV8N8eNjJVRD9pDkkLUNhmEo8_cL_sl7xy9mdajdH-T8J3TFQsjvoYQT61NFjQXy469Ed_BbBw_x4S1E=@protonmail.com>
 <20200104114603.GB1288021@kroah.com>
Feedback-ID: py-oVO8Vt0vS1FKaKugS2_MTpFC3lKhHMurhoXPAalWk9Eh40Mo1lZOn2CI1vswSSKJBwBLYgn_VKFu9qW3csg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        HK_RANDOM_REPLYTO shortcircuit=no autolearn=no autolearn_force=no
        version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is that ok ? Ordinarily I dont use protonmail, only because outlook mail is=
 blocked by kernel email system.
So I register this email to send plain/text emails.
I will resend it.

Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Saturday, January 4, 2020 7:46 PM, gregkh@linuxfoundation.org <gregkh@li=
nuxfoundation.org> wrote:

> On Sat, Jan 04, 2020 at 11:02:01AM +0000, atmgnd wrote:
>
> > accroding to bd0e6c9#diff-28615d62e1250eadc353d804f49bc6d6, will try ol=
d enumeration
> > scheme first for high speed devices. for example, when a high speed dev=
ice pluged in,
> > line 2720 should expand to 0 at the first time. USE_NEW_SCHEME(0, 0 || =
0 || 1) =3D=3D=3D 0.
> > but it wrongly expand to 1(alway expand to 1 for high speed device), an=
d change
> > USE_NEW_SCHEME to USE_NEW_SCHEME((i) % 2 =3D=3D (int)(scheme)) may be b=
etter ?
> >
> > Acked-by: Alan Stern stern@rowland.harvard.edu
> > Signed-off-by: Qi Zhou atmgnd@outlook.com
> >
> > -----------------------------------------------------------------------=
------------------
> >
> > drivers/usb/core/hub.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index f229ad6952c0..7d17deca7021 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -2692,7 +2692,7 @@ static unsigned hub_is_wusb(struct usb_hub *hub)
> > #define SET_ADDRESS_TRIES 2
> > #define GET_DESCRIPTOR_TRIES 2
> > #define SET_CONFIG_TRIES (2 * (use_both_schemes + 1))
> > -#define USE_NEW_SCHEME(i, scheme) ((i) / 2 =3D=3D (int)scheme)
> > +#define USE_NEW_SCHEME(i, scheme) ((i) / 2 =3D=3D (int)(scheme))
> >
> > #define HUB_ROOT_RESET_TIME 60 /* times are in msec */
> > #define HUB_SHORT_RESET_TIME 10
> >
> > -----------------------------------------------------------------------=
----------------
> >
> > 2.17.1
>
> Much better, but your From: name does not match your signed-off-by name :=
(


