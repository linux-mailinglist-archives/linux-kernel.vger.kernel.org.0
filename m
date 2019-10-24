Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3E3E3CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 22:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393431AbfJXUFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 16:05:24 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36720 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfJXUFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:05:23 -0400
Received: by mail-ot1-f67.google.com with SMTP id c7so122831otm.3;
        Thu, 24 Oct 2019 13:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WBu2xp9K0zCOL1CqUzXovGKYVoxLAufXdkmrTgDj8jU=;
        b=XeuUCZnWm+hwRU+YDhkMiG+NVrUiKaMWKxalRYws5Dzubg9r6peqH919pIJQL7S6N/
         NBe3UEqVehjYYOxKUUL5zg0dL3zlAn3OM8w5S09lNGRMdNVqvQXEHg33uqQ5kCz+Di+o
         pIHF0gUm0+B1RgFegsIs7AHWrZBuzJ51xk+rhKUfV7DEhHaOet71iMWx+300Ss/+LHPb
         Dch1IxrwWVMZN7V9oNdOwwZd9oLuTkKmvJ1L30MQVRUIRqRr/wSrBx2oG7/j0AAnRXPW
         4lhLBI2wz4CKedPaUc1oilbsH/1BZQetKCngek8F+mihvu4UYVe9rnXg891J4BqKXoa/
         QfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBu2xp9K0zCOL1CqUzXovGKYVoxLAufXdkmrTgDj8jU=;
        b=JqG4x1EOd7mvQZMBSoPfAPSF0aD2i2Vj2Z+69/f5AEqNg9hWJbjY/UPd1+1+6fw6GM
         XXiNp36QoNtQR8+i5O1N6+3ZVgQeg3m0CTb0YYJox9YZhTTHXi9dacCOXkJyWfE9TRzb
         UZxwDb+Rsh/WHz0yBKKGsSip73xiUpzIms66OkTlTR2jDbUFAXvKTtXEJaWrJoJU3HBb
         c6vwz+zyKYeQHeqadCtLhGYz9ntzUppaDs0hFz2TThEVFcnyPJPFVcZt3t2JneOgYnh5
         LcG407BZlM4XDQHJEUZyjuq/5uSNeg/JfW8VN1t63skVi6QNaQAcjpHuMAFlaMyT1j4R
         xE2A==
X-Gm-Message-State: APjAAAVEKvxfBJRrWz9Lbyaen3YSjBkXlXue2QsjBPPhiiwOBAuhmf9Q
        u2iAOwyYQFEaR+X0RjLDcI5X3REVldBsIRWO/HA=
X-Google-Smtp-Source: APXvYqyRn/htFtolYG6Dci882WX0tr+nJ6yni26IiDGYunzupqqnQojwMGy/hzW8960t1cB1jsSIJVVzhMr0jQjVgt8=
X-Received: by 2002:a9d:66da:: with SMTP id t26mr8688309otm.98.1571947522449;
 Thu, 24 Oct 2019 13:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191021132322.25256-1-narmstrong@baylibre.com> <875zkhdye5.fsf@gmail.com>
In-Reply-To: <875zkhdye5.fsf@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 24 Oct 2019 22:05:11 +0200
Message-ID: <CAFBinCBOEG6GT=dp5XQ3+nC18axSodPbgMfE6F7eHLE3gZfSoA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: dwc3: Move Amlogic G12A DWC3 Glue
 Bindings to YAML schemas
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On Tue, Oct 22, 2019 at 9:39 AM Felipe Balbi
<felipe.balbi@linux.intel.com> wrote:
>
>
> Hi,
>
> Neil Armstrong <narmstrong@baylibre.com> writes:
>
> > Now that we have the DT validation in place, let's convert the device tree
> > bindings for the Amlogic G12A DWC3 Glue Bindings over to a YAML schemas,
> > the AXG and GXL glue bindings will be converted later.
> >
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>
> Is this a thing now? Why do we need a new format?
this is a 2019 thing now, see an initial announcement from Rob from a
year ago: [0]

the new yaml schemas allow validation of the actual .dts
this can be used for verifying that the example in the dt-bindings is
correct, as well as for verifying the actual .dts file (so they match
the actual dt-binding)
(Rob's old mail - linked above - still has these two on the TODO list,
nowadays this works fine)

Neil is working towards full yaml schema based validation for all IP
blocks used on Amlogic SoCs.
with this patch we get a bit closer to that goal


Martin


[0] https://lwn.net/Articles/767723/
