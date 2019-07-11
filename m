Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B3D65956
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 16:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfGKOt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 10:49:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33412 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbfGKOt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:49:27 -0400
Received: by mail-io1-f68.google.com with SMTP id z3so13188681iog.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 07:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lx6jElU+VgfY4Bhw8zy9GLpHJyyAtrcr2M9tyhr/Psc=;
        b=PZfoYVp9w+orcqxhn0RgEJDYDszb/ij2M+Xb1Rfob0X38xwVFepTuTK4GQowApAVLo
         yvXCZ9vWsTJKt7CX9GrBIl7c9Z+J3FUNNNr/V84rKslZp5CdNzFRLYmrvGvlasrrZPqg
         kwPidg7mZdKlRJCF8TlVBRQ8ruTRBb6A394OA1BAZPx1FhkgWih7IMzx/RB1czYT4nPB
         BGaQfx/8d9SPe0jb3OW+l5/oxt18QmMhMRiid6I0e/VH2C8k4OmO3cRZonAv4IxB8nCa
         5ixREfY0l4lb0e1+XhrRHm5Gwu994algfl4wG7/OOXEU2R1MxEcNjCF+zCsek+agBbZd
         L6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lx6jElU+VgfY4Bhw8zy9GLpHJyyAtrcr2M9tyhr/Psc=;
        b=iHJVd44RvvAjLSJO1ry6Q7ybOYiE80+sf0gQo6q71ZMASppv49y7sTp8HtIVAmmIm7
         /nTTsW84kTni6V0FANYv0L5+L/OVUOcCClEjzb1YXZd/Ddi4lhYc87iaZ7ZUE2W4UGmk
         wo54uNifHXsC0UOnXtBy5DsbAGr2r1As9nHplWHAF/ypMgTLPufbb4iE+bN3ikXqzllr
         utMg8gqQ+KrOEi7/7LbWcuUlppJFh8U/Rnw5LWInXoPaI0/g2WQfFNNogvmKetHFqyeP
         pTn0607bGTqbzk6dvV32BPKjzmh0INZYC64JS+jVRBmZyYk0vDWgcZhDIVoOATMhNGWF
         OxuQ==
X-Gm-Message-State: APjAAAVI2qWU/62NEFfjWRki44/fYXNVpwZwbaABkjqU/c9cqwzRf6N2
        RZbO6RlsTN/m4nIv95+LM33d4KkSPxADSDcWtZ0=
X-Google-Smtp-Source: APXvYqxZQg9gmCNd9CO5UADhYdQTr+8XEM146+WZqrbqteXzrxKJ/9aWlv92Ercncs0hvYlqdh/GDlvo02YRcViHNEE=
X-Received: by 2002:a5d:9416:: with SMTP id v22mr4996202ion.4.1562856565809;
 Thu, 11 Jul 2019 07:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190607182517.28266-1-tiny.windzz@gmail.com>
In-Reply-To: <20190607182517.28266-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 11 Jul 2019 22:49:14 +0800
Message-ID: <CAEExFWvh9HMWNKeDNhx1vqTbUB=_117qCP1TjCxEFwiYV4N_FA@mail.gmail.com>
Subject: Re: [PATCH 1/5] random: remove unnecessary unlikely()
To:     tytso@mit.edu, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...
