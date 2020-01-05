Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 382B01305A4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jan 2020 04:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgAEDrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 22:47:45 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43274 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgAEDrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 22:47:45 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so30306730oth.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 19:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GP2GI6NkJEz9jUWcBar1y2VTJy7aIInquYchIZEDQnU=;
        b=V+UesUcL9RuWHzxxt/fLsx0RWz1a8ewAWzFVboakL9t/FZ3/jTF6bGwzLb4RhsdvFk
         +EMlrJ51sjTjH+T5q7oIcIL3Go0DjBKBMpIsdtIDLfr0V3DvVCckkzMstJXN1Kj/Pj/M
         KoAadoljnTyShp6PKwkymcUUaC67JxOofBiDdIH8YXU1BbR4nQsOzogtusvzouvdHBj+
         aFks6Zmg0byWBUlJY8Hae1P4f6GPLPSBwk6JBF4Ux+EHmPdAFfEqcjku7jfqwXiJh6bI
         zw4AHZsMiAOgAHdKPDqD1Srs6F8JLsigyGZveZ8bWuIzxWsPXDw82QoqNPK+clVGH9Xo
         uziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GP2GI6NkJEz9jUWcBar1y2VTJy7aIInquYchIZEDQnU=;
        b=l38jMgZb+PaKUL2KVEdxF6f9WRpC7PisDJbOb4hC7jWhPjL1LGPwFPl7/FzygAGYbs
         MTtMBsNUG86OrVYVWqkAeAarPmljEsngPxNAaL5I5WJ27+tqf0Izfqvmp6rc3OK8do76
         h1loAoW/X/McJKFEiRIJ4Xyo/nZSAswnFgb3w4I5Ge0oBxLukVJRyXTgkx1Mj3vsazQI
         iwIn91lV42LiXRBLqU2K5DpDjdAiFwRQ27Tg+j6BJ8GwJNzXXmQYTXBqPtJOf86EvnzX
         Y7q4PB9+Hl8+BC+On/edicptfzWZOkEITMSDfAnbGoeDrkgGBre15RZz3PzLGcYwhmO2
         ZTSQ==
X-Gm-Message-State: APjAAAVvQot3ej0D48e5y/5BQQSeRIvKpHLEvBg6+gJYsy6lYfmgAJma
        5RUtomKhagPV/Al3hymMatjwBMtBdeOYAAgexKGPCxELng==
X-Google-Smtp-Source: APXvYqxV6pQfrtx0jQNrN/ptcuI9FzX2nufGf61xwj4D8BUDhGPlMH1pJ1/KoNiKdl1wOVZZJd97Nssk+z+wr5D2Wso=
X-Received: by 2002:a9d:7592:: with SMTP id s18mr112024102otk.130.1578196064448;
 Sat, 04 Jan 2020 19:47:44 -0800 (PST)
MIME-Version: 1.0
From:   Evan Rudford <zocker76@gmail.com>
Date:   Sun, 5 Jan 2020 04:47:33 +0100
Message-ID: <CAE90CG6SGWKXToVhY5VH-AzUjC6UEwRzoisUXM0OQe9XgcCHRA@mail.gmail.com>
Subject: Is the Linux kernel underfunded? Lack of quality and security?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem of underfunding plagues many open source projects.
I wonder whether the Linux kernel suffers from underfunding in
comparison to its global reach.
Although code reviews and technical discussions are working well, I
argue that the testing infrastructure of the kernel is lacking.
Severe bugs are discovered late, and they are discovered by developers
that should not be exposed to that amount of breakage.
Moreover, I feel that security issues do not receive enough resources.

I argue that the cost of those bugs is vastly higher than the cost
that it would take to setup a better quality assurance.
With sufficient funding, the kernel might do all of the following:

- Make serious efforts to rewrite code with a bad security track
record, instead of only fixing security vulnerabilities on an ad hoc
basis.
- Although the kernel will always remain in C, make serious efforts to
introduce a safe language for kernel modules and perhaps for some
subsystems.
- Build an efficient continuous integration (CI) infrastructure.
- Run a fast subset of the CI tests as a gatekeeper for all patch sets.
- Run strict CI tests to ensure that userspace compatibility does not break.
- Run CI tests not only in virtual environments, but also on real hardware.
- Run CI tests that aim to detect performance regressions.

I realize that some companies are already running kernel testing
infrastructure like this.
However, the development process seems to either lack the resources or
the willingness to build a better quality assurance?
