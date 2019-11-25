Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5F2B1091A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 17:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfKYQMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 11:12:32 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42215 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfKYQMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:12:32 -0500
Received: by mail-lf1-f66.google.com with SMTP id y19so11461326lfl.9;
        Mon, 25 Nov 2019 08:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pwIL/irlcWNwmpTvJrew6iz5vbVsNdGhIhVpbssUodk=;
        b=VDOfdCfv4AfkHqlFUe01NzCuYRxzxuwoQs7XvIlLcoiHOK+fJnusvW3yWUaLaVpiNx
         VG4Dk3w/ohEms4NNvOxmsHJzLDWDK2CHkU9HXWt4OkoimgAFPnW67nneC3Fk2aAXoXdj
         DR/ospZTkd6t2BmyayEXGpJwnH3zLCW15FTW19/J2rKDf+L2o8UnTk32bqV2ooeaxguO
         0fIES1aO1cM7Ue+JliApX29Ly3B6WUxi5WRz2tooKCJ/zrVaw3tqVFjiY1YKY7c5nqpf
         Kd3fqsq0A7G2rxnDgYP2h+U7KO+TiDA7R3sqH7V+f6wTxeYhuwoX8qOXq2KhlrLdOMN/
         Qcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pwIL/irlcWNwmpTvJrew6iz5vbVsNdGhIhVpbssUodk=;
        b=JZnDoS2jgQZz/lJvqGgKmJJTXEyGSMUp2IOSEkiw6IstT+2jKZSKxmqeZcCeT1BvXN
         Avz0cDiRgxoh01xEK/C2uRBQE5HTBSZnVB/1x0/vqjQ5lXsgrpmfvIdhzUZ7OHlnWLwS
         hPoTx7xB8w/dMu9QDSnDrvIvfz/jg5kv/oWwQVzVaYzcfie2sifzui2X/5TXsVaP7Lac
         Sce43NKzS9dAurZX5E68VOR8Mgndf1g6UXfn1rnR97u+TTUjf8LI3ubLDlF1Wae7HuU3
         qeRJbpmtnzyInuO46W1rgMHEx5C7pQmbdhljXMs260zKeePHyckkC3FkOC8oKgcWYX5g
         LfZQ==
X-Gm-Message-State: APjAAAU/NbddSqLBYaE/t/5QIQ38efe3MiOsxcgLmPZv/DF1UBsEn3HZ
        N7ySqrj+4nwOxBSzj0GsQrWcjHm/sawZN8OdeI0=
X-Google-Smtp-Source: APXvYqz752SeEXFivN41Pet9Y0rxfrBFN4f7w+QRq7VC4oEC/DM9gSZ3msNcmW9TW7JLinnimAiSEMIAESbpSXF5CW4=
X-Received: by 2002:a19:ca03:: with SMTP id a3mr21554522lfg.20.1574698350303;
 Mon, 25 Nov 2019 08:12:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574693313.git.agx@sigxcpu.org> <1e452d74454d550ec4134428994ad8559aaa587e.1574693313.git.agx@sigxcpu.org>
In-Reply-To: <1e452d74454d550ec4134428994ad8559aaa587e.1574693313.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 25 Nov 2019 13:12:34 -0300
Message-ID: <CAOMZO5CvZ+6St5s=zk7xRDARSYVsox-VQA4kMfTtTTn43m4tOg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mxsfb: Add compatible for iMX8MQ
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Carlo Caione <ccaione@baylibre.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 11:50 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote=
:
>
> NXP's iMX8MQ has an LCDIF as well.
>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
