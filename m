Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8086C130E02
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 08:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgAFHeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 02:34:12 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:52650 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgAFHeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:34:11 -0500
Received: by mail-qt1-f201.google.com with SMTP id o18so11234916qtt.19
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 23:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hwg+2X/dPh6Rt2epUfRIb2mp0zKIH8H5oeMACxWCYPE=;
        b=SeAbFzLjhR+b0UiQhQ0vyiVteaaEpsbihkXBJGYIc3R6kb0bBqtfY8avhT4XOa3R1l
         lRRTEsifNgVRARlkXnKpXgt/aQ7OgQ4B6lXV8v722EMo2PgYB8/UY2FNlrDetzBSx+wb
         imE1AFBMes62JY7xUcPwoQukThsEwI43EPzW97gegfuE3QvwJ/ojVW1Cv3vbA40NMu5G
         Mzr39+unBcUb5CtsTZavjODGbRSu9UqXsnGTO5rGOgnzqfB9Zn7Tfr/rAwLhiYcev4vu
         13FrwIo7IEZqCDLJRfoKw2U1JjEkKkVpyJ2LW548/u9CJIdC3NeBKMbITu0boV5kWxq1
         opMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hwg+2X/dPh6Rt2epUfRIb2mp0zKIH8H5oeMACxWCYPE=;
        b=PyNF3h/S+5rQ3I2T8bBWz2H/F1wrcznsmvn8rQN8J1vO7QwhSxZm6wMDWHb7KZvoXx
         JNNBDSA23U3eq5w06NTgCbLSLRRT3u0bS14MW4NdK+mdF7ttrj1pjNKS2cTnfx/9rHZA
         TyuDR7epov3MOvLFP4v+S5vQxnty5pY7CNnkmCP0DVhFQw/efhamVx8bpOurDp/g+QKH
         UONZRfkSaeHcU1/ol5G60s8wHb8IXl/sqYhF/3zXsneJxJqwdrT2B8moUoCuSAIRqjTK
         NErdqJazJn7pM9qWVoWwUxxobxHWHZzsHuoPZNsVnrRFNNq09UAoQ7HsgxEqm8Wv6EB1
         p26g==
X-Gm-Message-State: APjAAAVaLp7w5PrRxE2Y64sxH2v3mZ9UnzS+zMp7XzV9nZ98SFp6qZch
        bvj8z9wczsGC0CVJ6uJSLQcG6TKHcktg
X-Google-Smtp-Source: APXvYqx0qukNheHEBOwMXOx9VBU1vr1+b0uQiPg/FwCVmGfMUvtGwHPbEzX1YnE5Qj8EmQP60u5J3NhSIjIc
X-Received: by 2002:a37:4b56:: with SMTP id y83mr82028694qka.42.1578296050370;
 Sun, 05 Jan 2020 23:34:10 -0800 (PST)
Date:   Sun, 05 Jan 2020 23:34:08 -0800
In-Reply-To: <20200104150238.19834-3-masahiroy@kernel.org>
Message-Id: <xr93lfql6ntb.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <20200104150238.19834-1-masahiroy@kernel.org> <20200104150238.19834-3-masahiroy@kernel.org>
Subject: Re: [PATCH v2 02/13] gen_initramfs_list.sh: remove unused variable 'default_list'
From:   Greg Thelen <gthelen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> wrote:

> This is assigned, but not referenced.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Greg Thelen <gthelen@google.com>
