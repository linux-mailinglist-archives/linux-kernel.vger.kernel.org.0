Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC001472D2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 21:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgAWUuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 15:50:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbgAWUuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 15:50:37 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A00EB2253D;
        Thu, 23 Jan 2020 20:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579812636;
        bh=D4LTdBYYcqv+ik1Pg4jtD5ZnmXsEUXj8mdhQQjWTksA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TGRTjbhNsL4XA1B13RstA2PBC9UNxAAcPQ1EhwHxew8oHjyEXFb0f0NlwSjrZJj8e
         +mtBcQfwSoBGDIVvAEWOEwb7Skz706EOwFZOEe3czEJaTyJ88CHL5ENeoqWnw2jry2
         6Al5UdFzlvY1OGGjrtuoTKD0oHuNdR3MHZnbRVKk=
Received: by mail-qv1-f50.google.com with SMTP id u10so2190641qvi.2;
        Thu, 23 Jan 2020 12:50:36 -0800 (PST)
X-Gm-Message-State: APjAAAVlWOCVPhVppxNA1Oi34q9wxdj6s7TLsANSiZ3LbzsNxvevZwe8
        01APxjdcBf9LweqluOEjqdHxPteDLQBmLldSDQ==
X-Google-Smtp-Source: APXvYqyrN/ifItlATEFTfxubxslw3zMCfRZgyB5QYn1GQetklMTcxJ3km4RPXJFBnI525IWkPPS16O71YGW8tHw1uvk=
X-Received: by 2002:ad4:450a:: with SMTP id k10mr17058351qvu.136.1579812635794;
 Thu, 23 Jan 2020 12:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20200122174005.17257-1-sravanhome@gmail.com> <CAL_JsqLq5XFdVRJa-XuTDbA_s=hpu3P4VGou=XfmSJs5NFAQqQ@mail.gmail.com>
 <3489a505-9992-037d-5007-6e5f5726a4e7@gmail.com>
In-Reply-To: <3489a505-9992-037d-5007-6e5f5726a4e7@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 23 Jan 2020 14:50:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ6B76nyQ8W8LPaM7czesqN54LE=nqd_Vaz++tQ65r2PQ@mail.gmail.com>
Message-ID: <CAL_JsqJ6B76nyQ8W8LPaM7czesqN54LE=nqd_Vaz++tQ65r2PQ@mail.gmail.com>
Subject: Re: [PATCH v8] dt-bindings: regulator: add document bindings for mpq7920
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 1:14 AM saravanan sekar <sravanhome@gmail.com> wrote:
>
>
> On 22/01/20 11:16 pm, Rob Herring wrote:
>
> On Wed, Jan 22, 2020 at 11:40 AM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> Add device tree binding information for mpq7920 regulator driver.
> Example bindings for mpq7920 are added.
>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>
> Notes:
>     Changes on v8 :
>       - fixed error reported by dt_binding_check
>
> Still broken. :(
>
> Sorry I cannot reproduce any error, yaml is parsed and mps,mpq7920.example.dts is generated
>   CHKDT   Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
> Please help me giving more detail

What about building the example? The build log is attached to the
patch in DT patchwork.

Rob
