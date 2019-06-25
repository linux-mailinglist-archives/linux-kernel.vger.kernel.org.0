Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC8954EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 14:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfFYMZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 08:25:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32976 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbfFYMZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:25:28 -0400
Received: by mail-lf1-f66.google.com with SMTP id y17so12501581lfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 05:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXFxBqw289PiWNcgire0HT3ql8msXi7Wbz9KDkqpi9s=;
        b=MRAi30L3bCnSstOAPK/5ckcFQXdc0wInrW51IaGWdmmXBFt61il5F8ZihENHrES6Sz
         A2gfTv6F6/mUQ1hGF0IliwV+O0FoVXmnwA27MN1197oDkrwe0Hi/euIeh0I/e8zRwLgI
         B96q10pu6xOvJvT96ewCQmj7xRCeReAq/kigc7RqYiguG/g1LmS2U+Jqm5eZcB10V30P
         n1xKUvlYhN7Wnj+Yn6gNqa//q0nip2EJKCYm4ov9IZvxiKcc17gouzhVRXMZya7Iff4C
         lW2YQjDxDHSucaIJuJ9qvDTzQoa0DUBHFUUnsRd1LRv4Ks9d9wHsSNTg7RA2sbTLxnRZ
         +rTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXFxBqw289PiWNcgire0HT3ql8msXi7Wbz9KDkqpi9s=;
        b=tbxp51RScw52ATkacKEjR9jczOQ+oc63D8m2MCCI/oHhvg/FXBSBm9Q7EdEbbkFY1o
         d+UZDgOQA7KfwLNB7RQp8NbYKO95W/kFwbTszCwUiGB0j3v5wP6MlG2D/cj7TkrggKUy
         MNCGnSDjt/EkGHK6tEWohhRHlik7bfO2bbfypSl75F4zPzTd9vatrrH6KqXepnjfKDlG
         dY65nyXC7aCDm6iC2u3R/Skv9NdVNH+EoGYtTbXogqTAPt7OCTlV223IPNbYeal7qmbS
         GSOOI+0VHbCiOWiAdHChGlFNVqzhaKxfwuto7y7qEcOSTTWeU67k0vMdGHpnlFbpMOkk
         QcCQ==
X-Gm-Message-State: APjAAAUBBlfe0XPfG9yIW6/B1CMYhBB+xjwsKzuFF3ujsjTM/zLNnpns
        8dRujvTf38A4F/H+actVRKLFhlBJYj1ZvQ847hd7CQ==
X-Google-Smtp-Source: APXvYqwMJafEsEK9ql82gdFybiq+Gag7JQbBkAhot7eiscPpABkzdiTqqeOrWV0XFwZvPlNTuzHyscjkjG+lDDOrlRA=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr13951212lfu.141.1561465526510;
 Tue, 25 Jun 2019 05:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190617215458.32688-1-chris.packham@alliedtelesis.co.nz> <20190617215458.32688-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20190617215458.32688-2-chris.packham@alliedtelesis.co.nz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 14:25:15 +0200
Message-ID: <CACRpkdbg3ewD0gexLk3+nF0ihyhnPPpWj13YDqxgvT_4urhbzg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: pinctrl: mvebu: Document bindings for 98DX1135
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:55 PM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> The 98DX1135 is similar to the 98DX4122 except the MPP options differ.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Patch applied as uncontroversial.

Yours,
Linus Walleij
