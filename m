Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4EACD3C1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 19:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfJFRFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 13:05:00 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41053 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJFRE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:04:59 -0400
Received: by mail-io1-f68.google.com with SMTP id n26so23611675ioj.8;
        Sun, 06 Oct 2019 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ClCXwi/HR6v0nj5tJBTnRSpqKbdtOUUK586xb5JDUJ0=;
        b=H2hsRIaAyT9Xy/esJm2nvsDH9vbpAiXZca6RGDF1U4rAarZ5nA0TpI092n7Lv5UDjV
         hT6/YA/1n6ceBIoEc2rKRTog40RGOKUomA/bK7ePMOvG4ue5h7BmoZQ+FkspN/K91goQ
         q5B5imlf92wSp2Woi+RqHxyzgF09d7iXyBanIMpu7gDW+TlMLbLYe6UnUqDwlXVBv48i
         szn/q0vp02HzPF7We/pSHc8e82miCKM6dFSoUDRgnx6j2imDvEMSmjjc8jprwRinlW6y
         AStGbcIdaCLAusdw2EuHxpOVw/eRDAqqaLwVWCI/ve3LNJqq03PQrVeLZGOer95H3Qix
         WonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ClCXwi/HR6v0nj5tJBTnRSpqKbdtOUUK586xb5JDUJ0=;
        b=Y1x1W1j6D7aiGVtdKNJDXeS9luufKySEtKZSFZAvxmspoe7GWo2wZEgIwyIgqrxZWH
         MHJj3mYyg26dDRwuTXYdaKUGD4RwYnhUmbhEcoHCyoW7Woejo/HCOr1DVW9e3nJVfpWe
         Z34zcnhkNUEPvrUmOcuLC4G9qfx81zS3sANPvBINI9e4HBmcTUYaVBFQD9qH1X6wwkMW
         eE3LuYpBUpIB6IzOlDGcrejNgBDlQw6ysDIwxNACGj6ap1Dfp6Fi6iZF2qnJVeMixy+C
         jhxm5qvEwwhR+gAnngBua/PhBOEP7IEULDnvSUWGSJFOjhe6+z1I9FX37cpiffgzWf8Q
         P7CQ==
X-Gm-Message-State: APjAAAW2HMGCS+b4X9bUuT3/f2Fa4MhFPwPW/gSHwX6IVqbHKQJI8ojx
        CrASCZB3lpjNIKjvPjMYz+K0NgQ8W/N30ZvYKGY=
X-Google-Smtp-Source: APXvYqx59hPBCA1dsvATyMaiZ3U2Ns8IhBB/Ple32/dXXypkjmmtRPbof1jOTnLY6s8PLIEuNMg3++oOuXSEM7EZO0A=
X-Received: by 2002:a6b:cd81:: with SMTP id d123mr22810239iog.78.1570381498362;
 Sun, 06 Oct 2019 10:04:58 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 6 Oct 2019 12:04:47 -0500
Message-ID: <CAHCN7x+oXNA6WRiq1OnDdcgDTJrm-QyazyYLw-ow0vPMMmrVbQ@mail.gmail.com>
Subject: Serial 8250 DMA Broken on OMAP3630
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Vignesh R <vigneshr@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone else had any issues using the CONFIG_SERIAL_8250_DMA on the OMAP?

I can use the DMA on the legacy, omap-serial driver, but when I enable
the DMA on the 8250-omap driver, I get missing frames in Bluetooth.

The older driver seems to have an ISR that seems to address a variety
of items compared to the very tiny ISR for 8250-omap.c.

I am not exactly sure where to start, but if someone has any
suggestions on how I can troubleshoot, please let me know.  As of now,
I have to disable CONFIG_SERIAL_8250_DMA to get the Bluetooth
connected to UART2 operational on a DM3730 at 3,000,000 baud, but it
appears to work just fine after some patches I just submitted for
handling RTS/CTS.  The legacy omap-serial driver works fine with DMA.

adam
