Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1024E23F06
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 19:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392992AbfETRaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 13:30:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36263 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbfETRaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:30:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id y124so6294505oiy.3;
        Mon, 20 May 2019 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w3D3DH3Fu6zPGdy8wXa33dC2jEvuVr+iNnwQmfWSS0A=;
        b=RwQKQ5Lzjd/yuajL0a8TD5eYFALJmVy/l4WPHaAm0uvSnsPctQQgAw6d+FL53P3XO+
         tVH/dmHBr4tWoRSg0D2+O9YID9dkErHYkq+waO0kd16D9M0Rw1Ptd87/76eph2FxXs2Q
         J2nuASsdqC60DP8hC3iA70GusQQ51PrrtW8tJcMteBoZX9KekgZE9gXFRUXv+ods5KUS
         pdxTei3UpwOKry8OecT22OkNIkvN3fV/tvppl6ThiKEy5lPTjgND6MoMQgZk0x4G4GLd
         XajQXeHS3FsHndEwTJ+6xe76ednJEIN4T/23dCy32gNlhrZJ/UOUhodFA2A/BLnDXnft
         yNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3D3DH3Fu6zPGdy8wXa33dC2jEvuVr+iNnwQmfWSS0A=;
        b=EJbwaNS+rDyaeyLfxihVqUrZk+mnqnoJcfhzs4pn1Vk14/PELdaws3h2+sWCYm6TmX
         nsKvwebI/YilTFdnUwLx+Kr1IpKLLW7MPR+hx1w+NQR7QpTaXe0AyV6QlpbRLkyUTQIF
         gEFPxUVnmGrmKZ7/mO8k93KQK03Ikf2KAN6VZ1x7RN84yxjQs7MM36BX0VtNSBa2k3ME
         ZBOPUzCei6SRnZX9fQkGITbrLDzbrB/eQ0ICtKix6eqTVhAEr0CUx7M35ehyX3sxhyAW
         2n6exoV8nWqAAfJ5wZlg0Ia2yuZpsSbsbQjOfeNHNNKWS63SEb59c4R82vnGwAnYfJgi
         vU8A==
X-Gm-Message-State: APjAAAUoFxSexVTJTH6YAWWhdIEYs8daGgtuV17RIuiXnCiQht3yETA3
        PDr9vyqZqsyDMr19asEVAo65eGfd8Oapfhzk40GLUQAQptU=
X-Google-Smtp-Source: APXvYqyLRbhJiUJnsx/pAcLvvDyXpHCdWvCHHLtXqlVfdYX4QYuiPeY9+IVY0NVqnhXOrfr7IAkrogU21iwbgyH6EcU=
X-Received: by 2002:aca:ed0a:: with SMTP id l10mr216571oih.39.1558373405148;
 Mon, 20 May 2019 10:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190520131401.11804-1-jbrunet@baylibre.com> <20190520131401.11804-3-jbrunet@baylibre.com>
In-Reply-To: <20190520131401.11804-3-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 19:29:54 +0200
Message-ID: <CAFBinCAGDwqYcTGvj0d2Pvazj406HbB6+_S8fOSPD+AOZy6vzQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] arm64: dts: meson: g12a: add ethernet pinctrl definitions
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 3:14 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Add the ethernet pinctrl settings for RMII, RGMII and internal phy leds
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
