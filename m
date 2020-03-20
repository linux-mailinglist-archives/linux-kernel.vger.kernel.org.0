Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E75418D4DA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 17:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgCTQtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 12:49:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40610 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgCTQtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:49:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id t24so3359961pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 09:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=/ipVe6H1zjRQ3n1A4zatA7ipvQEaxuKms3PaZ37HPp8=;
        b=lYWiXd3SGfFgR6UtHP0c0V3MSwHAtevmmbtdgPV6Xjqb/AkI3TBBJcY6KNGenPpmqi
         rYpgmp5fNaKFZgNVU29XVa1jSAB8citYic+Q9GI9pL0vMfyGXrhtRcLv0t9/u+uhJDwK
         gkxHI851nyFNZodXq1EB62sKpK2GhvlcrQiG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=/ipVe6H1zjRQ3n1A4zatA7ipvQEaxuKms3PaZ37HPp8=;
        b=LUHN0lE921j9V1tag/lRCxblkC562wl9sQ33JHcUmMNkzzRAC+lv91WywK7mheL0BI
         yztbXC6QVKq/D8QoNdmZlXJowh6/CXsRbNHRgUeuKm3WlQrT9LMyt81P/lC0Ct1AXjwb
         2mlQS+X9QH0vQiNQ1Zg37S3fl0nyBQ7BhIwbTvMFrAXrxxy4iDhFdOiC4mw4xJnjSR9Q
         Z51CfyIkHF4s2qVVH40AZU/YTWSFEQkc5J0ZQm8KJWvP0fxexi+eKat4QmyBSZU0EzJS
         ZiovxGil9r+znNOp5ysgYpJM71UVESNsirsKpCMTO+KLa1oOXAh3orLN5FXYvOsrWHJf
         kExA==
X-Gm-Message-State: ANhLgQ2Iaig3hRd53mciIS4EynnNyLX9BQInac+2qjb7jLWkT3qF7mPb
        SGEpzpTZYjolhjHzRgxyT1dttWnoVHM=
X-Google-Smtp-Source: ADFU+vtxgbGsFdAVCJQ2s90mNARSdrbN0uCEsug5z7SckFioJ2fgpjuGhUt/CgZJcMmVe/VbIF8q8A==
X-Received: by 2002:aa7:8d82:: with SMTP id i2mr11021445pfr.179.1584722939511;
        Fri, 20 Mar 2020 09:48:59 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v29sm6039051pgc.72.2020.03.20.09.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 09:48:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200320163820.3634106-1-vincent@bernat.ch>
References: <20200320163820.3634106-1-vincent@bernat.ch>
Subject: Re: [PATCH] scripts/gdb: replace "is 0" by "== 0"
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Vincent Bernat <vincent@bernat.ch>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Vincent Bernat <vincent@bernat.ch>,
        linux-kernel@vger.kernel.org
Date:   Fri, 20 Mar 2020 09:48:58 -0700
Message-ID: <158472293810.63184.3695647310984420546@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vincent Bernat (2020-03-20 09:38:20)
> While for small numbers, using "node is 0" works with CPython, it is
> more portable to use "node =3D=3D 0". Moreover, with Python 3, this
> triggers a syntax warning:
>=20
>     SyntaxWarning: "is" with a literal. Did you mean "=3D=3D"?
>=20
> Signed-off-by: Vincent Bernat <vincent@bernat.ch>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
