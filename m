Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E0496654
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 18:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbfHTQ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 12:27:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39422 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfHTQ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:27:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 686E4283D55
Message-ID: <26b78fe57106f47d34f14bec2f81732af40c3d8d.camel@collabora.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: imx: add imx8mq nitrogen
 support
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>
Date:   Tue, 20 Aug 2019 18:27:39 +0200
In-Reply-To: <CAL_JsqJx6pTw7Pr=7f0jkC81JF+EDkyhHrvFehSWZV=0wy+YXQ@mail.gmail.com>
References: <20190819172606.6410-1-dafna.hirschfeld@collabora.com>
         <20190819172606.6410-2-dafna.hirschfeld@collabora.com>
         <CAL_JsqJx6pTw7Pr=7f0jkC81JF+EDkyhHrvFehSWZV=0wy+YXQ@mail.gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-19 at 14:08 -0500, Rob Herring wrote:
> On Mon, Aug 19, 2019 at 12:26 PM Dafna Hirschfeld
> <dafna.hirschfeld@collabora.com> wrote:
> > From: Gary Bisson <gary.bisson@boundarydevices.com>
> > 
> > The Nitrogen8M is an ARM based single board computer (SBC)
> > designed to leverage the full capabilities of NXP’s i.MX8M
> > Quad processor.
> > 
> > Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> > Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> > [Dafna: porting vendor's code to mainline]
> > Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Please add acks/reviewed-bys when posting new versions.
> 
Hi,
Thank you for the remark, I forgot to add it. I will add it in the
next.
Regards,
Dafna Hirschfeld

> Rob

