Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2053BE8454
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 10:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbfJ2JXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 05:23:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:23494 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbfJ2JXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:23:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 02:23:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="asc'?scan'208";a="374491389"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga005.jf.intel.com with ESMTP; 29 Oct 2019 02:23:09 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 8/9] dt-bindings: usb: generic: Add role-switch-default-host binding
In-Reply-To: <20191028215919.83697-9-john.stultz@linaro.org>
References: <20191028215919.83697-1-john.stultz@linaro.org> <20191028215919.83697-9-john.stultz@linaro.org>
Date:   Tue, 29 Oct 2019 11:23:05 +0200
Message-ID: <87bltzj47a.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

John Stultz <john.stultz@linaro.org> writes:

> Add binding to configure the default role the controller
> assumes is host mode when the usb role is USB_ROLE_NONE.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> CC: ShuFan Lee <shufan_lee@richtek.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: Yu Chen <chenyu56@huawei.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Jun Li <lijun.kernel@gmail.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Jack Pham <jackp@codeaurora.org>
> Cc: linux-usb@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/generic.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Document=
ation/devicetree/bindings/usb/generic.txt
> index cf5a1ad456e6..013782fde293 100644
> --- a/Documentation/devicetree/bindings/usb/generic.txt
> +++ b/Documentation/devicetree/bindings/usb/generic.txt
> @@ -34,6 +34,11 @@ Optional properties:
>  			the USB data role (USB host or USB device) for a given
>  			USB connector, such as Type-C, Type-B(micro).
>  			see connector/usb-connector.txt.
> + - role-switch-default-host: boolean, indicating if usb-role-switch is e=
nabled
> +			the device default operation mode of controller while
> +			usb role is USB_ROLE_NONE is host mode. If this is not
> +			set or false, it will be assumed the default is device
> +			mode.

Do we also need a role-switch-default-peripheral? Would it be better to
have a single role-switch-default property which accepts "host" or
"peripheral" arguments?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl24BPkACgkQzL64meEa
mQak5hAAtqbNYucc2pTH08oz9rTV4WYIfklt98huh9YuE00EQJ+Evm9c3omsUVQH
m7w+nsp638nKWPp+o7VY8rjYy3FljWW451JHB+fl4UqodgcqJAgqby264Lg5QPs3
x1l77KmxC1sFYb3lE3sG5k73dEB7WtCGsyPCIHmzX3JlgdhjJH0EPfYSmmug2mI8
2/6hEuF32BOZtwpnB0bDhfUuNb0OkwcRuJA4j+azR5F0DDmUODtiFneWRWN//Dc4
J5VBlSo+KvhOMETbyPOz25gElPaPPVm+X+TyzL1EA/eySvhUaWWiwUA2i4gGKmkz
Dbm5L6jRiYFEhVIvVo+yMtsYEu1zQ98cBnf4o0eg1BctxetEO/SVNfbe1ufKaTd/
ZM2lrVWyg7c+AlpgKuMz/jwi5cRZIS9NFvqf8w5JnuSl+ig06wLj+cm2JOvZbEeA
LtJteyVN5AF2RecNRmP+kOP052lrPRA+8aKE1j6WrXp9LC4N0wEzhxEXNxxsoMx0
zPNSz2G4Yf2K1u0nK7nMzy+Dx/+yYGPWYehbr3N4ZQvIxvsepad/HvMq6eGuCzZP
5ZcM7O/7Oklpy/wnPXDC0y2zb+e/9mJDpl5svtQR5xDrq3VNg9QAnmU6G+DElYco
cczjLDTbJAN7+sBOqdSKS6tvh8LNv3IFU1Lq1JbFoLMyAULF/C0=
=ln50
-----END PGP SIGNATURE-----
--=-=-=--
