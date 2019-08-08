Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDC108643A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 16:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbfHHOWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 10:22:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfHHOWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:22:52 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2EF62171F;
        Thu,  8 Aug 2019 14:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565274171;
        bh=tmkfuAM/VbXi3dTJBiWU5XaSo7kk4pDqqmiZFl+44xQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=idwlynjPbBO/yUvNgJr70HsK0+t/fvVE1CKsCOHBRfBkZkPihTmqCqs3Bg+kdrlKw
         QHFbPlSllNo7AWJh9xKgRB7Os0vZcCOvwgBBA2ookWbAUh/n3fFBiMdu5cNSUs4OtD
         ddQxC7GHaiqiOztdTb8Pn92dNo50/UsBAgeuB53Y=
Received: by mail-qt1-f179.google.com with SMTP id n11so92285702qtl.5;
        Thu, 08 Aug 2019 07:22:51 -0700 (PDT)
X-Gm-Message-State: APjAAAXOtRjpHb1Rj1LZv6z8YL+DBPjGnqN25+POjaOOgqbcg6exBD9T
        L1kjm/FJUlB+wqxX5OiIA63o+vAILCW+jyU9Cg==
X-Google-Smtp-Source: APXvYqwuFDlDdhRjgs2OPhZLe+JL3U+8wBZdlI8Nkb5wYrKcFge+RCokmdszImo6kO7eQS5L3w25UCHbyuo3F8pjpiw=
X-Received: by 2002:a0c:b786:: with SMTP id l6mr13538682qve.148.1565274171003;
 Thu, 08 Aug 2019 07:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190808085522.21950-1-narmstrong@baylibre.com> <20190808085522.21950-3-narmstrong@baylibre.com>
In-Reply-To: <20190808085522.21950-3-narmstrong@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 8 Aug 2019 08:22:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJgjjPzb4uWaJ-M=11-LRjByyRcHmot6iRyK-dXMOnkxg@mail.gmail.com>
Message-ID: <CAL_JsqJgjjPzb4uWaJ-M=11-LRjByyRcHmot6iRyK-dXMOnkxg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: display: amlogic,meson-vpu: convert
 to yaml
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 2:55 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Now that we have the DT validation in place, let's convert the device tree
> bindings for the Amlogic Display Controller over to YAML schemas.
>
> The original example has a leftover "dmc" memory cell, that has been
> removed in the yaml rewrite.
>
> The port connection table has been dropped in favor of a description
> of each port.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/display/amlogic,meson-vpu.txt    | 121 ----------------
>  .../bindings/display/amlogic,meson-vpu.yaml   | 137 ++++++++++++++++++
>  2 files changed, 137 insertions(+), 121 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
>  create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
