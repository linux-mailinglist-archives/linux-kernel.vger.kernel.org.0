Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0EB819128E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 15:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgCXONa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 10:13:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44501 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgCXON3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:13:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id z3so20786664edq.11;
        Tue, 24 Mar 2020 07:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izwnIJDLX3PpcKebrw2ejCdxD31bp4HV/owZTH+UT9g=;
        b=HG4va0y9ptHh02lYhjFJlq3MVsocAX+qz7OV0CNLJ+lcF9w/afL82Fu1gjQM04xwhO
         CjZTMxfDlrnGjpBdVNmCPkTxrt+IkSia7ehhd4DwTeovr1wTk9Pygcm18lFH5t5h+o4b
         wRypSA2BKiZACkE8PvNp2FIWfwfSHdfsqqkT5KQODnQhwIYJbeGW4HHn0qbIQFvmp4c2
         d+EsKD2Lml8P0zyZ8y6MKBLX7vbH7nVcyKYtDQ9IkxLHDJlBrlcrw3TG2Whc6GMGwAzO
         FVcU73Sa7Ct6bV5RFKeW+A6Qk62ThRLx9N0Sd2pcVBShMno1NMHUKqRSu5oxqQEFe9Wa
         Sitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izwnIJDLX3PpcKebrw2ejCdxD31bp4HV/owZTH+UT9g=;
        b=QDrar4xOfJC3L1fvVY+iTR7d8WM3vSbyppoXv/uOXF3BCh6OOmqdQw91Zn6YYLSmEg
         TcUs788rmEC5i+uxgto66/umfBO8OMVuZYx64YjbG8OZ2venY5Frrsz9mJ4uWQPA/g9h
         MGwDlgmK5QVwqc8FgsdqNHpH7du3/PoMbUNOriInvajE5T3VjUJStRgpK3afsRqafr2g
         RVwDtpJbHWfUf7gfMjhvzrv6/mzv2iE3fzhO9lMcOVXqo+kQ8ly+/Rz+sXq+LS+zJWci
         Gc9N23K+aZxXz8Xqt95wE+Pj+kjT/7xS125ORGFwHraul9lPXzAYbMnNJ+YKp5gBivm8
         3BCw==
X-Gm-Message-State: ANhLgQ2Vlqr0P51fKrpcB3o2J5hmVYKJLWAqadpZah9NWAVykeMWIJyc
        oMTChBQBcb+/ximdvnaJWTGp73GktUNQzzFs+A0=
X-Google-Smtp-Source: ADFU+vt7WPNeMNKBzxAaGY+0/pg49GFYOhCk2fM4aFzPzmKpP7OAgJPKW+5rkQPYjZ8OEAPMTAU0beLSAlgB28Pi17k=
X-Received: by 2002:aa7:de13:: with SMTP id h19mr27826422edv.52.1585059207305;
 Tue, 24 Mar 2020 07:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200324102030.31000-1-narmstrong@baylibre.com> <20200324102030.31000-3-narmstrong@baylibre.com>
In-Reply-To: <20200324102030.31000-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 24 Mar 2020 15:13:16 +0100
Message-ID: <CAFBinCA9rQKWx47F2-dT4ZrCwSKW+LiwAH2VdzPKr-9ymRxkSw@mail.gmail.com>
Subject: Re: [PATCH 02/13] usb: dwc3: meson-g12a: specify phy names in soc data
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hanjie Lin <hanjie.lin@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, Mar 24, 2020 at 11:20 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> +static const char *meson_a1_phy_names[] = {
> +       "usb2-phy0", "usb2-phy1"
> +};
my understanding is that the A1 SoC only has usb2-phy1.
+Cc Hanjie Lin to confirm this

apart from that:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Martin
