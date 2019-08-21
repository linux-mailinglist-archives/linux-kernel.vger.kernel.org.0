Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 202B79866E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 23:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfHUVQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 17:16:21 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40216 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730825AbfHUVQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:16:20 -0400
Received: by mail-ot1-f66.google.com with SMTP id c34so3441686otb.7;
        Wed, 21 Aug 2019 14:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wy67vtg4FuvAzi/1thnqtWwMGxJc2ol+TXZYnC2Wttg=;
        b=a2O1vB4Y49uXu/YYItvHjbx8LCiQcbyjAm/Rg+tNrA6uUwgqAM9CrmD4bSpBTTXuDu
         iSVsIo3yV2zalMhVpg9kgCyEPYK9YhA9aSaPjW2nULXZ8gnIEpLuFCFRV6DnHVyMgB7N
         CLDGK1jWYIuNGZEZXxLX244J9cI87vERUmjzloXmJ5PYEFEBp2TqVwKhqTBTVaM0iMIx
         VHQfjQ3Nj2cSMbkUWJTjC7FiB2GOjEU2DflOay1t+D2GA2j/uFkQqJCtfLVcBM+nA7DO
         /zwm4uPilpepuw83s8MkJyOWrjme1iNahWs/lJj8AaaZTiqXgsPnaJ2P/flNZ884VbAB
         0jkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wy67vtg4FuvAzi/1thnqtWwMGxJc2ol+TXZYnC2Wttg=;
        b=JwwaeI47x/dZq5WCMWdRux26Dr5fWJ3+G/7mAw1MtM3CftC1KNZ0mWwytaz9nsJOfp
         EG3l7OChdl79AZweOqQDE/dPHHzI/2PMW5gXKmPVxxDSsqs7HEnm/f7/RCFzCcGEce6e
         xKc8INlv4cnN6NGN/KgoIIcLEthAxuBQH/voLcYlMPQTqVLdL2n6YMNnpLWtGA4EaHYr
         IBe4y/d7uf5prrjD/tdrvNO47p3wVIJJYc+rTrb8Df/6OnWFpIOeysfd8C19URSWwaFx
         pEM3UK8NM4SOx5E/CeDXkZTMcrCzBcPH7a8LNABZaoGDDGH9wPrh56oWuCVa93sdovOB
         C5Fw==
X-Gm-Message-State: APjAAAUGX9hmG/z7/bP7Zw8UGLLLTXFJe5MCqKFvxDD76XjWyf/tUp0w
        UBDs87rm+afIDIxKPTa0YWMEWdb9ZBunL+4d3Oo+SjaI
X-Google-Smtp-Source: APXvYqytlWgxY8yGmmM2cDJEDZWBH8EhWi4sU/WAkNbOda8BuOcH06CPK1GZ26evpCKulTW/urt+yxS8POSbZvKXF4s=
X-Received: by 2002:a9d:1d5:: with SMTP id e79mr27849218ote.98.1566422179039;
 Wed, 21 Aug 2019 14:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190821142043.14649-1-narmstrong@baylibre.com> <20190821142043.14649-9-narmstrong@baylibre.com>
In-Reply-To: <20190821142043.14649-9-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 21 Aug 2019 23:16:08 +0200
Message-ID: <CAFBinCDd7fnUxysHFK7DTSRwYOO788TRPtB=CSHRkGVSXW6xSg@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] arm64: dts: meson-gxl: fix internal phy compatible
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 4:23 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This fixes the following DT schemas check errors:
> meson-gxl-s805x-libretech-ac.dt.yaml: ethernet-phy@8: compatible: ['ethernet-phy-id0181.4400', 'ethernet-phy-ieee802.3-c22'] is not valid under any of the given schemas
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
based on the explanation in v1 we can program any arbitrary PHY ID so
Jerome's argument to list the PHY ID here applies
with that:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
