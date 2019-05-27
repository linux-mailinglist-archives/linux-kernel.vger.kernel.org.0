Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A89112BA16
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 20:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfE0S0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 14:26:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39105 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfE0S0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:26:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id r7so15529382otn.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kEK8YEn82uZl3KtekPFpQObwQps/VzOazNNdEv6HIBA=;
        b=QDIRZ07yzcoElXx1D5ucFSGI3eU44JhkikzDlIE9bnlzRVnEM9LhsO50yqcl21AGha
         9kmUcGS0oL53IGMo08aR3nyTp5v7yS48O08Am9Q6zNRoxi2hdAfm9MpMHGed/eSNMhpa
         iLBCl+FLUYgSCC7gmBAQ7YDoxHRmex1pFUbX06J24JSTjn6yaNFjEmknNVP7k4luXkV6
         6aI1+2hG4rnvkESpzhGGrJNWbUU6hhvQyecWN39Sl/nT1deo9xjaXOiN33n9HhZXl4Og
         alAzIqNGSjcsErpW038oaoWDU2T/uGXpyh0NYmggXAAGNHqpvEuNXhuOiHbY/Sp6MAfM
         mFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kEK8YEn82uZl3KtekPFpQObwQps/VzOazNNdEv6HIBA=;
        b=Qv1N5eHKinxGXpGccEiF/hfEAiNjmLbbHzLwwVvv851gaUp+eqJHfs+M26nzXzKSaZ
         NoenKM4EOG4x+VngLsioEmnRUTKKDMsLRhzXOdGhjO04NQQzrOvmxtVUHBFfZIhaT/dY
         yXhlPuD+5tEKJvccyk3PAFRPgNIX/+gr4MvDglxeMwQdSUCapH44cXcNcFrIBUykw5a+
         r/Pi2l8OM6E6WczcTVloQ+BwY/aCedfDD8+0sAI5SWtTut+u0fsB1EXSiCqLI71rngqj
         gyu4QK0O/mxe7NfbpkEO0pAxSRD1YpCCTCGMDVgI0qKEwl8RnurY982oDrlbUy3lrabb
         rHTQ==
X-Gm-Message-State: APjAAAXrBMS54EXDm3M7vfnTnKSe8dX3zBYPqfwULhHe39EiXutYCrbp
        fCBLOiou3WYc6Wezsa9sOKyFXDVOSY41J/ze8/w=
X-Google-Smtp-Source: APXvYqxO8mD3SqAenWNr+oA/vGJ22mekTdcIzROJVXOaweez4x2pUntpBksdEFug2PfumowB8H85gwXbyoy3O0xWdDE=
X-Received: by 2002:a9d:69c8:: with SMTP id v8mr18611131oto.6.1558981563581;
 Mon, 27 May 2019 11:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190527132200.17377-1-narmstrong@baylibre.com> <20190527132200.17377-11-narmstrong@baylibre.com>
In-Reply-To: <20190527132200.17377-11-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:25:52 +0200
Message-ID: <CAFBinCDDGPqnFQjtJx8Ny7nuoKScq4qYwkNhznU+3TMMDOFWfw@mail.gmail.com>
Subject: Re: [PATCH 10/10] arm64: dts: meson-gxbb-vega-s95: add ethernet PHY interrupt
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        christianshewitt@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:24 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the external ethernet PHY interrupt on the Vega S95 board.
>
> Suggested-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
I don't have this board (anymore, mine died) nor the schematics but it
matches other GXBB boards and looks correct so:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
