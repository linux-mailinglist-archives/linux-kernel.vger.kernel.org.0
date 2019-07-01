Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3AD59DC5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 16:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfF1Oby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 10:31:54 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42070 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfF1Oby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:31:54 -0400
Received: by mail-qk1-f195.google.com with SMTP id b18so4951078qkc.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=Uju8gAoL2FSd0BoR2yjK3o7K4quQv4RFLaEwScDClBg=;
        b=MZjUebscuzehbtzLPoCchK24ZvHPRqg0Dg+M5nNFg1PHjVsnaiipZXRRwADO9KMivP
         gKqu130CVmBN+4HGttgftwRlA47gK96rKvD8cuBm4MN3GKGShK+llu3b9f/AsB/XCswY
         VlYBjOjzPCh8tJxxOa7FWtmIj8FCiyXUQTrcBVz0/F1Q2hWefZ8aFfq5JB4v80qB9zyM
         j1nnW181y71R9txmE6RBcGE512mKe0uJrF1Jz9Wqx+7CyN2TMKHw28XLSLm0oe9kKYRN
         eMsWJfpJXZ9jY9qcdMtShWExoHqo5Y2IeNnxpHyHne/lqQY27nglHFrZo02OD+TWtac0
         /apA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=Uju8gAoL2FSd0BoR2yjK3o7K4quQv4RFLaEwScDClBg=;
        b=W2sqhicQIMdT6WpX2W+/jUYs1eQZ6h6coPtnEjbZei+S5QOB/sTahDMY6HcBnJspHg
         E7nx16zKONObaZI5rsggtwdkKTJ6yEEGjZyxmTDfw28L53els8vSLMKaG9OYbcTnczv7
         cODShIAq4L7SlN02heEZDcnbGi5sJK0FfmiusNM71D99cjeG3vZz+HajD1NOHtymuZ2G
         3eZKBB8zBKt/3CtpH5h9M2qGHuVGE1zOl+8U9N//6OUhK/5NuUvB4zYHE/y0DoigHTm5
         aQ8YI3ch2Ylq7ds9OkRbkX6Cf99dC5oCAlpxrv/tNsk2hcMlQOdwrzKZkUyLLM2KXrTD
         MlLQ==
X-Gm-Message-State: APjAAAU6TFGttbpHh9f61Xo185yDlz/t7cjQWmfN4vflcq7mHtaikpEF
        M0QYEnxCAvLYq+O/4urQHDB8lA==
X-Google-Smtp-Source: APXvYqxKTGW2Go5hPw8aWvdYhpCS5FVsz7IC7uVCxo2hCWeWk3BNhw7CAy+F73STHxlNFRbv9/JoFQ==
X-Received: by 2002:a37:7786:: with SMTP id s128mr8231301qkc.345.1561732313154;
        Fri, 28 Jun 2019 07:31:53 -0700 (PDT)
Received: from tpx230-nicolas.collaboramtl (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id w80sm1138593qka.74.2019.06.28.07.31.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 07:31:52 -0700 (PDT)
Message-ID: <18f834cb4885357ce6274115096911d90b9c17ea.camel@ndufresne.ca>
Subject: Re: [PATCH v2 00/11] Venus stateful Codec API
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 28 Jun 2019 10:31:50 -0400
In-Reply-To: <eba506ce-4d63-649a-80e6-efad20125263@xs4all.nl>
References: <20190628130002.24293-1-stanimir.varbanov@linaro.org>
         <9c3399a8-4fc6-3117-10ee-3395cee034da@xs4all.nl>
         <997204c7-c702-868c-9a49-52fefc9ab3d2@linaro.org>
         <eba506ce-4d63-649a-80e6-efad20125263@xs4all.nl>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-7GNINHKy+QfnqJkWj32i"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7GNINHKy+QfnqJkWj32i
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 28 juin 2019 =C3=A0 16:25 +0200, Hans Verkuil a =C3=A9crit :
> On 6/28/19 4:23 PM, Stanimir Varbanov wrote:
> > Hi Hans,
> >=20
> > On 6/28/19 4:37 PM, Hans Verkuil wrote:
> > > On 6/28/19 2:59 PM, Stanimir Varbanov wrote:
> > > > Hello,
> > > >=20
> > > > Here is v2 of the Venus transition to stateful codec API
> > > > compliance. The v2 can be found at [1].
> > > >=20
> > > > Changes since v1:
> > > >  * codec_state is now enum
> > > >  * dropped IS_OUT and IS_CAP macros and use vb2_start_streaming_cal=
led()
> > > >  * corrected g_fmt and reconfig logic
> > > >  * s/vdec_dst_buffers_done/vdec_cancel_dst_buffers
> > > >  * use v4l2_m2m_ioctl_try_decoder_cmd M2M helper
> > > >  * various fixes to make v4l2-compliance pass the streaming test
> > > >=20
> > > > To test the streaming with --stream-from-hdr v4l2-compliance option=
 I have
> > > > to make the following hack (it is needed because the size of decode=
r input
> > > > buffers (OUTPUT queue) is not enough for the h264 bitstream, i.e th=
e driver
> > > > default resolution is 64x64 but the h264 stream is 320x240):
> > > >=20
> > > > diff --git a/utils/v4l2-compliance/v4l2-test-buffers.cpp b/utils/v4=
l2-compliance/v4l2-test-buffers.cpp
> > > > index c71dcf65b721..dc0fcf20d3e4 100644
> > > > --- a/utils/v4l2-compliance/v4l2-test-buffers.cpp
> > > > +++ b/utils/v4l2-compliance/v4l2-test-buffers.cpp
> > > > @@ -1294,6 +1294,11 @@ int testMmap(struct node *node, unsigned fra=
me_count, enum poll_mode pollmode)
> > > >                                         fmt.s_sizeimage(fmt.g_sizei=
mage(p) * 2, p);
> > > >                         }
> > > >                         fail_on_test(q.create_bufs(node, 1, &fmt));
> > > > +
> > > > +                       for (unsigned p =3D 0; p < fmt.g_num_planes=
(); p++)
> > > > +                               fmt.s_sizeimage(fmt.g_sizeimage(p) =
* 2, p);
> > > > +                       node->s_fmt(fmt);
> > > > +
> > > >                         fail_on_test(q.reqbufs(node, 2));
> > > >                 }
> > > >                 if (v4l_type_is_output(type))
> > >=20
> > > Does the venus driver set sizeimage based on the given output resolut=
ion?
> >=20
> > Yes.
> >=20
> > > E.g. if v4l2-compliance would first set the output resolution to 320x=
240,
> > > is the returned sizeimage value OK in that case?
> >=20
> > Yes.
> >=20
> > Here are few options to me:
> >  - set the correct resolution
> >  - set 0x0 and sizeimage at some arbitrary value (1 or 2MB). Despite if
> > the bitstream is 4K it will not be enough if the bitrate is huge.
> >  - invent some mechanism to trigger reconfiguration on the OUTPUT queue
> > as well (similar to the CAPTURE queue)
> >=20
> > > And this also means that the venus driver requires each buffer to hav=
e
> > > a single compressed frame, right? I.e. it can't be spread over multip=
le
> > > OUTPUT buffers.
> >=20
> > I cannot say for sure but that is how all downstream cases uses it i.e.
> > one compressed frame per input buffer. I wonder if you fill input
> > decoder buffer with many compressed frames in one input decoder buffer
> > how you pass the timestamp for every packet?
> >=20
> > > We really need to let userspace know about such restrictions.
> > >=20
> > > Stanimir, can you list the restrictions of the decoder for the variou=
s
> > > codecs?
> >=20
> > What you mean? Restrictions like "one compressed frame per input buffer=
"?
> >=20
>=20
> Yes :-)

I think I just had the same discussions through some RPi patches
reviews. All the stateless codec drivers we have so far assumes full
frames and some wording iirc specified this in the spec at some point.
That removes ambiguity for timestamps application. Even though,
timestamps in V4L2 are useless for B-Frame enabled streams (ffmpeg and
GStreamer will ignore them).

Nicolas

--=-7GNINHKy+QfnqJkWj32i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXRYk1gAKCRBxUwItrAao
HEd7AJoD6UTL2Ch2lIuU3By7HzfYUqaOmgCgu6kMeEhOmohXcnAqEsjr9N8otzU=
=y1YL
-----END PGP SIGNATURE-----

--=-7GNINHKy+QfnqJkWj32i--

