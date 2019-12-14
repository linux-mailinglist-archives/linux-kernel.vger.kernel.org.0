Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9064811EE96
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 00:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfLMXhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 18:37:10 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38122 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMXhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:37:10 -0500
Received: by mail-pj1-f68.google.com with SMTP id l4so375257pjt.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 15:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tF6xdK1TQEpV0ca/a8wufcbAcaB6WhDiqEVYvGb6uhs=;
        b=W65FZ2NQ40E8ZrPUZqpwMkACkURu8VvP7cijSt3X33k6G4rRp4o394FqZO2HlypuFU
         dsVJaCgtkevg3hRalCY/3ws1RsXJmxVdxItbiNnVEvQ5vfydCiaP9fbVdl75HiSM8CBm
         gYNj0rucxPNIQ579iEkV01EITevFEkZvTp/UGxAkpPhuVX4nEkzkwmPRp8KwV33WmpFk
         aG7YzCY8tqP1lKddIs6AfQgN7Pm0iqESBEBm3UXzwq6G2KTA98Mw79CHUoDHOi18acD3
         JwSGsvPMZvhKoeTpsNaZbV1u44RiEfz5ZnYhPW+tFlR8svVGrRjDMEdYFysM4y/uaLic
         Mujg==
X-Gm-Message-State: APjAAAUqbMY3AhfFSfAy17JGPnxjVOSIai5HIdkwn1hdcWIiOCpYt9bw
        BPxPSp8k8fL5e3TB6FPpbSFJvuIOOsImIw==
X-Google-Smtp-Source: APXvYqzfPIuZ4Gb5M5ULcsSTk3pF3OP38N9iIZRAA+ioiIlI2JfIKCU5254HtwslcsUzCK9KFF+Ziw==
X-Received: by 2002:a17:90a:374b:: with SMTP id u69mr2331439pjb.23.1576280230004;
        Fri, 13 Dec 2019 15:37:10 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::c0f4])
        by smtp.gmail.com with ESMTPSA id d77sm13708534pfd.126.2019.12.13.15.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 15:37:09 -0800 (PST)
Date:   Fri, 13 Dec 2019 15:37:07 -0800
From:   Dennis Zhou <dennis@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] percpu: Separate decrypted varaibles anytime encryption
 can be enabled
Message-ID: <20191213233707.GA89837@dennisz-mbp.dhcp.thefacebook.com>
References: <alpine.DEB.2.21.1912131330150.51759@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1912131330150.51759@chino.kir.corp.google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, Dec 13, 2019 at 01:31:46PM -0800, David Rientjes wrote:
> From: Erdem Aktas <erdemaktas@google.com>
> 
> CONFIG_VIRTUALIZATION may not be enabled for memory encrypted guests.  If
> disabled, decrypted per-CPU variables may end up sharing the same page
> with variables that should be left encrypted.
> 
> Always separate per-CPU variables that should be decrypted into their own
> page anytime memory encryption can be enabled in the guest rather than
> rely on any other config option that may not be enabled.
> 
> Fixes: ac26963a1175 ("percpu: Introduce DEFINE_PER_CPU_DECRYPTED")
> Cc: stable@vger.kernel.org # 4.15+
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  include/linux/percpu-defs.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
> --- a/include/linux/percpu-defs.h
> +++ b/include/linux/percpu-defs.h
> @@ -175,8 +175,7 @@
>   * Declaration/definition used for per-CPU variables that should be accessed
>   * as decrypted when memory encryption is enabled in the guest.
>   */
> -#if defined(CONFIG_VIRTUALIZATION) && defined(CONFIG_AMD_MEM_ENCRYPT)
> -
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>  #define DECLARE_PER_CPU_DECRYPTED(type, name)				\
>  	DECLARE_PER_CPU_SECTION(type, name, "..decrypted")
>  

Applied to for-5.6.

Thanks,
Dennis
