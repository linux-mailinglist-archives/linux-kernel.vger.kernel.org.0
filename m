Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0201719A37A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 04:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbgDACPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 22:15:13 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46566 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731427AbgDACPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 22:15:12 -0400
Received: by mail-lf1-f66.google.com with SMTP id q5so19056354lfb.13;
        Tue, 31 Mar 2020 19:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTX+2islckicUBdDqhO5fJeYE0TjuqLAF7CpNcSNMao=;
        b=BOjJF7U5oCICrJcisMaLwUe2fWyaBcoRYOjccvuerasUkZpI04l80GEz6IdvVMaonY
         YRTeBEvEhxWgbiN2qBkWhArDAnza56TQMB6cOLvgnheSiq/1fJmXeRUDXz/4a7mzVtuM
         mP92qsU69l0GDSUx00kcEP/0aVZVwhF61SKHGtYoupj/wAkeT6TwmulGWNTKvtM73G6+
         dGbAlSpPlaXijkbFdXjDfk9cdHpZeQN6FdXylxV6RnQmQQtumj1pnm2gI6Y1BvrQzhjA
         MxVwlUqIXQSR+wKbQQXhuSfhfcnTJj3H+cSAKlYHaiw5SeQP2ljC5lY6FzWmEEKcLVi3
         OdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTX+2islckicUBdDqhO5fJeYE0TjuqLAF7CpNcSNMao=;
        b=tpqIeq4OuVRTft+L8fjH7CcYPYFum2Xf0jMGYLFmA5p0aZ+c4et6oFE6AllsCm9VC9
         CEVkXNK5jK2iqK5m1OCwcjQksmfEkrbt9YGEQ63pH/0QXKvN1sET2afhSPHZehwgFMOP
         8biySnHfd4Dv6HxhQSQov0hnJk5u65PZYRa4Erhndr2eirZfLxfcowvsNWdBhMh98uwT
         FKTP46xvf/VLPnsnmuh9Zofws7LeOuUExye1FF8f9GyheH3rnYCQe/MZ4bqtG63WI7PQ
         KpT2u3MXQ47e2MMnOo1YuwXA2M/3XFsShiqiwdlsPB6j24RpP2hBx8pL2hjVZgWvYEWN
         KBsQ==
X-Gm-Message-State: AGi0PubjL3OWalY7wuVWSmWkRaXVGLo42jtQQW6T7Qf3b43NT3LD64BC
        XOO9n4xugjiOvcBsz0eXBgf5iE7KAHz1mTJnF0s=
X-Google-Smtp-Source: APiQypIM53+BHKTpdC3LAAzHpk6+HbNwqnX3j+63secbytSV4i15OjsC8Hjxzqai67N72StO4XFAa84vBWs85MDyzg4=
X-Received: by 2002:a19:be94:: with SMTP id o142mr13146328lff.13.1585707310572;
 Tue, 31 Mar 2020 19:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <600e0b027a4e62a4aea8900e5a1e95e3e14b10f0.1584943873.git.baolin.wang7@gmail.com>
 <20200331174021.GA4288@bogus>
In-Reply-To: <20200331174021.GA4288@bogus>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 1 Apr 2020 10:14:58 +0800
Message-ID: <CADBw62r6+SsnMh=48Pny02MGcEqSmUs4bNFXpibu6BMJwwrVhg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mailbox: Add the Spreadtrum mailbox documentation
To:     Rob Herring <robh@kernel.org>
Cc:     mark.rutland@arm.com, jassisinghbrar@gmail.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 1:40 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Mar 23, 2020 at 02:13:46PM +0800, Baolin Wang wrote:
> > From: Baolin Wang <baolin.wang@unisoc.com>
> >
> > Add the Spreadtrum mailbox documentation.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > ---
> > Changes from v1:
> >  - Add 'additionalProperties'.
> >  - Split description for each entry.
> > ---
> >  .../devicetree/bindings/mailbox/sprd-mailbox.yaml  | 62 ++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
> > new file mode 100644
> > index 0000000..0848b18
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/mailbox/sprd-mailbox.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Spreadtrum mailbox controller bindings
> > +
> > +maintainers:
> > +  - Orson Zhai <orsonzhai@gmail.com>
> > +  - Baolin Wang <baolin.wang7@gmail.com>
> > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sprd,sc9860-mailbox
> > +
> > +  reg:
> > +    items:
> > +      - description: inbox registers' base address
> > +      - description: outbox registers' base address
>
> > +    minItems: 2
>
> This is redundant, drop it.

OK.

>
> > +
> > +  interrupts:
> > +    items:
> > +      - description: inbox interrupt
> > +      - description: outbox interrupt
> > +    minItems: 2
>
> Same here.

Sure.

>
> With that,
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for your comments.

-- 
Baolin Wang
