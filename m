Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D1A1399D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 20:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgAMTK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 14:10:58 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33334 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbgAMTKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 14:10:54 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay11so4193776plb.0;
        Mon, 13 Jan 2020 11:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:cc:cc:subject
         :references:in-reply-to;
        bh=/p04BREkLvITkBNCvAdnBDiDser6FK1YoySTcH9jrZ4=;
        b=JEny2FFah8QmDWXzS7u7W6J4ffaGLvSfbX7SJ4mPmf2iaiZuGszGFL+ClfzL9AEXeh
         tyiRJfcRM5srN75pI3Drn07gC7U5+giEDIb16tSjxNKZYnHqdZ4d27mqv8EJSAYznTbD
         RqQadnGLgvlTu1aTvOJj9f16xlJUHxSeIE44LnbzMIfIKYxDo9oV+557tmQwnyDNB3hE
         Trw9xRIsseJohAaeIgQ3KfgJbk3hOU/3ihv+vN2+Vt0nFZj1kKmhAPfTurUF4ekVUDNN
         lJZx+q+3OeQnTkX4iXIE8vKNnVwH6PBez1RxKkWxKfuSmBTqGmP7qrRLShgkN/DvRHgZ
         cVCA==
X-Gm-Message-State: APjAAAXy1uzPUSRuG4NWD94Ee7B1HikByCuAcMytrpnihtQiyaFPZnNq
        lMGKE4Tb85YQpf0xAok9ydQ=
X-Google-Smtp-Source: APXvYqy5YnODGE7hZtm/lttivtOJvaWOV/c/vfZY3+JllbjlAi1yu2WDBZ40YMIg02twfp787Iksjg==
X-Received: by 2002:a17:902:8e87:: with SMTP id bg7mr15822195plb.279.1578942653932;
        Mon, 13 Jan 2020 11:10:53 -0800 (PST)
Received: from localhost (MIPS-TECHNO.ear1.SanJose1.Level3.net. [4.15.122.74])
        by smtp.gmail.com with ESMTPSA id b1sm14178611pjw.4.2020.01.13.11.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 11:10:53 -0800 (PST)
Message-ID: <5e1cc0bd.1c69fb81.502fd.1a2b@mx.google.com>
Date:   Mon, 13 Jan 2020 11:10:52 -0800
From:   Paul Burton <paulburton@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>
CC:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     linux-mips@vger.kernel.org
Subject: Re: [PATCH] MIPS: ip22-gio: Make gio_match_device() static
References:  <20200112165110.20427-1-geert@linux-m68k.org>
In-Reply-To:  <20200112165110.20427-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Geert Uytterhoeven wrote:
> Unlike its PCI counterpart, gio_match_device() was never used outside
> the GIO bus code.

Applied to mips-next.

> commit 70eec920d4f2
> https://git.kernel.org/mips/c/70eec920d4f2
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paulburton@kernel.org to report it. ]
