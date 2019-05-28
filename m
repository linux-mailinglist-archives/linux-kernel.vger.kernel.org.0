Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3392CABF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 17:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfE1PzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 11:55:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34065 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfE1PzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:55:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id n19so11757814pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=ph096faZXzVdBs0AC2/h3o4Rlcsxk1w4xdVivoEx9ik=;
        b=R3rNeE3EFPAheEu0f9OTGy+8ImI3GH2tAv4HZNBSXj+weZKn6WpjuMnGJVU/550ci2
         BqdwJ92g6+fUHbMDAaeYXvy5/c5Z0ns7wON9xfv70YFOjQhvuIq52IxP0V9zOsjOV2MG
         EWBgiHzXSGUeFETN+PgnJ9QT9SHOxXXCTWZ2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=ph096faZXzVdBs0AC2/h3o4Rlcsxk1w4xdVivoEx9ik=;
        b=CYee9VPaCNhCeIvHDQnwFU58pBme9Kntw5dBSWVzlDucLNoRIGBTr3pmdgg4QPBF/s
         eZFUzfm0HHyZJ7SmZcz7xvncBwtz4Zu9UtmQlfdL4FmQcqvA+gh6t1hWuLGH9nFjFE3q
         zUH+NHfzc9qytRzF3pKj1E/9t/9w4U953SI5vyIe6ECvWQ+PxyWLRu16JkXQuikjVODQ
         7fHTA91DwiyrrR2CqFjhxMJ4lQ6g3ieYmvb43t9tElAltVnVRQ1A5RdN6azTl6qXlJhS
         tlFDdxVsQQpsjJN/583clYQuLpv7j/wNiYwgzxqtr/44INiuxRWPjoYn4CB34QSKHwjg
         ZicQ==
X-Gm-Message-State: APjAAAVuUl59L4olYuO6VISW5UAREikAA/U5MAx7qrVxnGjt4w5MW8LD
        zBphlEZyjkKId16G/G7zMRksZA==
X-Google-Smtp-Source: APXvYqyfKz47JLrEjKSbaeCi8/nJyaDNU3BrFSZmaS/tvxlIWn5U0R9ZRrZJBXxc3AQWCJ9jccOIuQ==
X-Received: by 2002:a17:90a:ac03:: with SMTP id o3mr6908759pjq.114.1559058905466;
        Tue, 28 May 2019 08:55:05 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g22sm14805937pfo.28.2019.05.28.08.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 08:55:05 -0700 (PDT)
Message-ID: <5ced59d9.1c69fb81.c3ee5.96d3@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190527043336.112854-3-hsinyi@chromium.org>
References: <20190527043336.112854-1-hsinyi@chromium.org> <20190527043336.112854-3-hsinyi@chromium.org>
Subject: Re: [PATCH v5 3/3] arm64: kexec_file: add rng-seed support
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
User-Agent: alot/0.8.1
Date:   Tue, 28 May 2019 08:55:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hsin-Yi Wang (2019-05-26 21:33:36)
> Adding "rng-seed" to dtb. It's fine to add this property if original
> fdt doesn't contain it. Since original seed will be wiped after
> read, so use a default size 128 bytes here.
>=20
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

