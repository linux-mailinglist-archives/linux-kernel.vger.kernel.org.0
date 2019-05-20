Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76E0D23C5A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 17:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392230AbfETPkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 11:40:39 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:47112 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388841AbfETPki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:40:38 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4KFeAtY025207;
        Mon, 20 May 2019 11:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=mOjOVxgcejFl/WDind0ZveLYCA7TQeGWu/4jmKsfGS8=;
 b=uS1XjUKAwSpF549rIymaDWLiUJyDk3noc2/xJ/raO/Qu7cQ9HJLFa2WwsouDLrHyZqzX
 LMjMbj3UJ3X0qxAUOBgzvsoA2oRPLo0ILtJ2ihxCxlrTDtVaS/EJCSwdTjvZXXmThzp/
 5HGvTsJMG2Y/NMjNoEXyv152jCZQdufKhyGvoBMRH301J1BOEpH21bhRGf58UDOiKUaH
 OL1oXK+ot6YBCw89lvp8WA5MIQe9WZv1n3dmqeNAfaQX31kSeWCAIPkHQRkq2a1bJWIR
 jiDWCmxmY2HePN0GUFGnashgYZS2LCtC2oPPgTzRb/kao+Z/u1HnKq/keI8kTKvcxi4b zw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2sjd444nv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 May 2019 11:40:37 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4KFc8n1085318;
        Mon, 20 May 2019 11:40:37 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0a-00154901.pphosted.com with ESMTP id 2skxgxrrkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 11:40:37 -0400
X-LoopCount0: from 10.166.132.134
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="340212726"
From:   <Mario.Limonciello@dell.com>
To:     <mathewk@chromium.org>, <linux-kernel@vger.kernel.org>
CC:     <acelan.kao@canonical.com>, <dvhart@infradead.org>,
        <andy@infradead.org>, <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: intel-vbtn: Report switch events when event
 wakes device
Thread-Topic: [PATCH] platform/x86: intel-vbtn: Report switch events when
 event wakes device
Thread-Index: AQHVDDI6B2xG1URud0uFVvgshAA3U6Z0LBvw
Date:   Mon, 20 May 2019 15:40:34 +0000
Message-ID: <d2dac2d720574c58bb0d273809f46cf9@AUSX13MPC105.AMER.DELL.COM>
References: <20190516215615.261258-1-mathewk@chromium.org>
In-Reply-To: <20190516215615.261258-1-mathewk@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905200101
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905200101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
> owner@vger.kernel.org> On Behalf Of Mathew King
> Sent: Thursday, May 16, 2019 4:56 PM
> To: linux-kernel@vger.kernel.org
> Cc: Mathew King; AceLan Kao; Darren Hart; Andy Shevchenko; platform-drive=
r-
> x86@vger.kernel.org
> Subject: [PATCH] platform/x86: intel-vbtn: Report switch events when even=
t wakes
> device
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> When a switch event, such as tablet mode/laptop mode or docked/undocked,
> wakes a device make sure that the value of the swich is reported.
> Without when a device is put in tablet mode from laptop mode when it is
> suspended or vice versa the device will wake up but mode will be
> incorrect.
>=20
> Tested by suspending a device in laptop mode and putting it in tablet
> mode, the device resumes and is in tablet mode. When suspending the
> device in tablet mode and putting it in laptop mode the device resumes
> and is in laptop mode.
>=20
> Signed-off-by: Mathew King <mathewk@chromium.org>

Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>

> ---
>  drivers/platform/x86/intel-vbtn.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/int=
el-vbtn.c
> index 06cd7e818ed5..990cc8c20872 100644
> --- a/drivers/platform/x86/intel-vbtn.c
> +++ b/drivers/platform/x86/intel-vbtn.c
> @@ -76,12 +76,15 @@ static void notify_handler(acpi_handle handle, u32 ev=
ent,
> void *context)
>  	struct platform_device *device =3D context;
>  	struct intel_vbtn_priv *priv =3D dev_get_drvdata(&device->dev);
>  	unsigned int val =3D !(event & 1); /* Even=3Dpress, Odd=3Drelease */
> -	const struct key_entry *ke_rel;
> +	const struct key_entry *ke, *ke_rel;
>  	bool autorelease;
>=20
>  	if (priv->wakeup_mode) {
> -		if (sparse_keymap_entry_from_scancode(priv->input_dev, event))
> {
> +		ke =3D sparse_keymap_entry_from_scancode(priv->input_dev,
> event);
> +		if (ke) {
>  			pm_wakeup_hard_event(&device->dev);
> +			if (ke->type =3D=3D KE_SW)
> +				sparse_keymap_report_event(priv->input_dev,
> event, val, 0);
>  			return;
>  		}
>  		goto out_unknown;
> --
> 2.21.0.1020.gf2820cf01a-goog

