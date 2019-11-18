Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5921F100774
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 15:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKROem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 09:34:42 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:58002 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfKROem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:34:42 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CD33B1C17F8; Mon, 18 Nov 2019 15:34:40 +0100 (CET)
Date:   Mon, 18 Nov 2019 15:34:40 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, Pavel Machek <pavel@denx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Fix incorrect NULL check in
 create_yamaha_midi_quirk()
Message-ID: <20191118143440.GB22736@duo.ucw.cz>
References: <20191113111259.24123-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <20191113111259.24123-1-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-11-13 12:12:59, Takashi Iwai wrote:
> The commit 60849562a5db ("ALSA: usb-audio: Fix possible NULL
> dereference at create_yamaha_midi_quirk()") added NULL checks in
> create_yamaha_midi_quirk(), but there was an overlook.  The code
> allows one of either injd or outjd is NULL, but the second if check
> made returning -ENODEV if any of them is NULL.  Fix it in a proper
> form.
>=20
> Fixes: 60849562a5db ("ALSA: usb-audio: Fix possible NULL dereference at c=
reate_yamaha_midi_quirk()")
> Reported-by: Pavel Machek <pavel@denx.de>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Thanks for doing this.

Acked-by: Pavel Machek <pavel@denx.de>
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXdKsAAAKCRAw5/Bqldv6
8uJHAJ0V4w8ERJieyS0YtELNz6wNz7/WQACffTMMwfwbjocL5KTpauKs4pQYtRA=
=GZs0
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
