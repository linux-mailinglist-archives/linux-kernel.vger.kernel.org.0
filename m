Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B729E14732C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 22:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgAWVfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 16:35:22 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37763 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbgAWVfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 16:35:22 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so3475247lfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 13:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5JEo2S95QV9RzdysiSqX6sLlLVR7bGOobEMqZB4SbLo=;
        b=LrAqB744pt/J8vqkIc85K0oHNitxTEwLxcSEUaIu43WhAUvXxzMBCno2LvKfhQXu0L
         QMnDBsNc3YXR2shrIDVs0cUYKafdaONjLDcBPiNDFxzTadHp5C4whl76dAFOre9YwVzU
         SY5P5FuMOtoNfri/t2DbZOWE9hkwyIdKhD+6dX4Frdz9995yNciwne+2Og90Q1HkEPiX
         NuHYw4ugQZx1YCWveavpWPHRqj1dsxgKFKB39MCg2ouG++cHgAe6Ch91a9z0efCDXaHQ
         2k7yiw90gujkm3E+HDqwQmF2Ea0YT5OQ0JDQimumZ7sEChjjoRThspQXQ+9ucSEyluzb
         +R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5JEo2S95QV9RzdysiSqX6sLlLVR7bGOobEMqZB4SbLo=;
        b=uKToQvhugTNogQ8m/6p7HGmNLx15UtVqqVcysTruwd5Y0J0ee4WILxULiHwiJTPfRE
         OuKDklOAIeKx3nnq//xbilKdQrnyMi9T1JfuWBv+KpvNri1V8OlZnkX5EgoLJHjJZUAj
         l33jk0j8mhCa58i6jn0Vx/FCCse6MQb1d87S1diRAMifbwJ5gSeyG1NwEfDCkGpH72UF
         19nzkpAco8SXNcdKkvd7VR+7vj5FoRTYQOUPdO1vj056kWPhnXo15up4e5JcX4RspbSp
         //gBTB6rkwP9M9j1eEx86deLXVBZJr2L1KL18SM1a20IWWDablNThL2vnT/XfrGJ+TSg
         d+EQ==
X-Gm-Message-State: APjAAAUO7wZnpmAdTK+wB0d1kusX/Y4Pfm/ot2qJTUiF4HmS99DKQ0JV
        QCvox27oG3Hp5CqZsdTmQyQs85N+ElCsPBpzTIWb5w==
X-Google-Smtp-Source: APXvYqx0p8hvRbgBC26M9FVdzAYzLSri+D8u6aFzpfJCv9MmjQWjujEFU9JKr/o3Xmz+P0huC2zlxY0gHbxp1WC7mHE=
X-Received: by 2002:a19:c307:: with SMTP id t7mr5721872lff.166.1579815320173;
 Thu, 23 Jan 2020 13:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20200120223201.241390-1-ebiggers@kernel.org> <20200122230649.GC182745@gmail.com>
In-Reply-To: <20200122230649.GC182745@gmail.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Thu, 23 Jan 2020 13:35:08 -0800
Message-ID: <CA+PiJmRBM-0J+LAckrvzg_bxEF+EmjwG5_PzgiWJ7SQu219p2g@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] fscrypt preparations for encryption+casefolding
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 3:06 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> I've applied this series to fscrypt.git#master; however I'd still like Acked-bys
> from the UBIFS maintainers on the two UBIFS patches, as well as more
> Reviewed-bys from anyone interested.  If I don't hear anything from anyone, I
> might drop these to give more time, especially if there isn't an v5.5-rc8.
>
> - Eric

The patches look good to me. Thanks for the fixups.
-Daniel
