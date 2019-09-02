Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E3DA5A4D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 17:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbfIBPOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 11:14:44 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34155 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730248AbfIBPOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:14:43 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1i4o2O-0004um-Kc; Mon, 02 Sep 2019 17:14:36 +0200
Message-ID: <1567437274.3666.9.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/2] dt-bindings: reset: pdc: Convert PDC Global
 bindings to yaml
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Rob Herring <robh@kernel.org>, Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org
Date:   Mon, 02 Sep 2019 17:14:34 +0200
In-Reply-To: <20190902150138.GA29400@bogus>
References: <20190901174407.30756-1-sibis@codeaurora.org>
         <20190901174407.30756-3-sibis@codeaurora.org>
         <20190902150138.GA29400@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-02 at 16:01 +0100, Rob Herring wrote:
> On Sun,  1 Sep 2019 23:14:07 +0530, Sibi Sankar wrote:
> > Convert PDC Global bindings to yaml and add SC7180 PDC global to the list
> > of possible bindings.
> > 
> > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> > ---
> >  .../bindings/reset/qcom,pdc-global.txt        | 52 -------------------
> >  .../bindings/reset/qcom,pdc-global.yaml       | 47 +++++++++++++++++
> >  2 files changed, 47 insertions(+), 52 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
> >  create mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-global.yaml
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thank you, both applied to reset/next.

regards
Philipp
