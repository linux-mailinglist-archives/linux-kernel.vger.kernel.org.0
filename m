Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0676C185212
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Mar 2020 00:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbgCMXH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 19:07:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43123 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgCMXH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:07:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id u12so5855992pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 16:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hRom7Sc1NCqF1xeeIsXbNTOQ/R2yiGgq1/0XkCiCX70=;
        b=ed+q42Wsbm/vD3d97MteFRiRkHh53VmH4DbR2F/ihY2kzSFA2EmAE9xYzeUIuLUk1v
         4qJwQ2hR1Znw6uuO422aqYdC8z1z8xdmTXzFUmhQooyo+BYKkynF3wlgmgvyYrYXJ3Yn
         hENkVRWggk2OjAEIy9XXOP2s48kr2x8fYJ0UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hRom7Sc1NCqF1xeeIsXbNTOQ/R2yiGgq1/0XkCiCX70=;
        b=GdNoL1NamR62WlN4FUjs+WawaPNIzM9+Kk3/TfEhAEhPHcAl8pp8rxWq+efn0ONBdQ
         cH0+qlnrvwO2uxCCRa1JppQ/khyB/yUmXDkSIujiuFvD3UvTURMFTKS51JaG122iFs7X
         hBoXJ3KgPeEiUqq93f4SQxKU+R6d5h4+gg4rMtYVAIn4o+i8gyE8YIHA+9N1x8z+ITo/
         JQAJhbRFspVWgS3i/0Tp/2yXIZKeHeVV2nKtYJbGITd7u+drfBnksaf+JEw2yyMTbBNU
         d7CIaf+wFEHYfFQsPw7NSW9FURtO7AfXZhA3UgrKQ9N2iIvQzL/L0M+H4wB6rzhLVDIo
         z2/A==
X-Gm-Message-State: ANhLgQ2bvXd04xGLqlgG9MOV/eJhYpIWOrZzBhwIhXgPPHd2mYVn+q/4
        D6BKPfudRuczIxFslmSecOrD4w==
X-Google-Smtp-Source: ADFU+vuLRXbo8KsJYUAnmHdWopZo1j5qDf1NEn16zxm0uM4zLaOgEWqTRdvJL1vH9ayOgX9IyqPczQ==
X-Received: by 2002:a65:494f:: with SMTP id q15mr15281897pgs.383.1584140874788;
        Fri, 13 Mar 2020 16:07:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q30sm13377505pjh.5.2020.03.13.16.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 16:07:54 -0700 (PDT)
Date:   Fri, 13 Mar 2020 16:07:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     gregkh@linuxfoundation.org, tkjos@android.com,
        linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        ardb@kernel.org, arve@android.com, hridya@google.com,
        joel@joelfernandes.org, john.stultz@linaro.org,
        kernel-team@android.com, linux-kselftest@vger.kernel.org,
        maco@android.com, naresh.kamboju@linaro.org, shuah@kernel.org
Subject: Re: [PATCH v2 2/3] binderfs_test: switch from /dev to a unique
 per-test mountpoint
Message-ID: <202003131607.10FDF99191@keescook>
References: <20200312131531.3615556-1-christian.brauner@ubuntu.com>
 <20200313152420.138777-1-christian.brauner@ubuntu.com>
 <20200313152420.138777-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313152420.138777-2-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 04:24:19PM +0100, Christian Brauner wrote:
> Unprivileged users will be able to create directories in there. The
> unprivileged test for /dev wouldn't have worked on most systems.
> 
> Cc: Kees Cook <keescook@chromium.org>:
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> /* v2 */
> - Kees Cook <keescook@chromium.org>:
>   - Switch to unique mountpoint through mkdtemp().
> ---
>  .../filesystems/binderfs/binderfs_test.c      | 47 +++++++++----------
>  1 file changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> index 0cfca65e095a..818eb49f8125 100644
> --- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> +++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> @@ -139,29 +139,25 @@ static int __do_binderfs_test(void)
>  	int fd, ret, saved_errno;
>  	size_t len;
>  	ssize_t wret;
> -	bool keep = false;
>  	struct binderfs_device device = { 0 };
>  	struct binder_version version = { 0 };
> +	char binderfs_mntpt[] = P_tmpdir "/binderfs_XXXXXX",
> +		device_path[sizeof(P_tmpdir "/binderfs_XXXXXX/") + BINDERFS_MAX_NAME];
>  
>  	change_to_mountns();
>  
> -	ret = mkdir("/dev/binderfs", 0755);
> -	if (ret < 0) {
> -		if (errno != EEXIST)
> -			ksft_exit_fail_msg(
> -				"%s - Failed to create binderfs mountpoint\n",
> -				strerror(errno));
> -
> -		keep = true;
> -	}
> +	if (!mkdtemp(binderfs_mntpt))
> +		ksft_exit_fail_msg(
> +			"%s - Failed to create binderfs mountpoint\n",
> +			strerror(errno));
>  
> -	ret = mount(NULL, "/dev/binderfs", "binder", 0, 0);
> +	ret = mount(NULL, binderfs_mntpt, "binder", 0, 0);
>  	if (ret < 0) {
>  		if (errno != ENODEV)
>  			ksft_exit_fail_msg("%s - Failed to mount binderfs\n",
>  					   strerror(errno));
>  
> -		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		rmdir_protect_errno(binderfs_mntpt);
>  		return 1;
>  	}
>  
> @@ -170,7 +166,8 @@ static int __do_binderfs_test(void)
>  
>  	memcpy(device.name, "my-binder", strlen("my-binder"));
>  
> -	fd = open("/dev/binderfs/binder-control", O_RDONLY | O_CLOEXEC);
> +	snprintf(device_path, sizeof(device_path), "%s/binder-control", binderfs_mntpt);
> +	fd = open(device_path, O_RDONLY | O_CLOEXEC);
>  	if (fd < 0)
>  		ksft_exit_fail_msg(
>  			"%s - Failed to open binder-control device\n",
> @@ -181,7 +178,7 @@ static int __do_binderfs_test(void)
>  	close(fd);
>  	errno = saved_errno;
>  	if (ret < 0) {
> -		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		rmdir_protect_errno(binderfs_mntpt);
>  		ksft_exit_fail_msg(
>  			"%s - Failed to allocate new binder device\n",
>  			strerror(errno));
> @@ -194,9 +191,10 @@ static int __do_binderfs_test(void)
>  	/* binder device allocation test passed */
>  	ksft_inc_pass_cnt();
>  
> -	fd = open("/dev/binderfs/my-binder", O_CLOEXEC | O_RDONLY);
> +	snprintf(device_path, sizeof(device_path), "%s/my-binder", binderfs_mntpt);
> +	fd = open(device_path, O_CLOEXEC | O_RDONLY);
>  	if (fd < 0) {
> -		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		rmdir_protect_errno(binderfs_mntpt);
>  		ksft_exit_fail_msg("%s - Failed to open my-binder device\n",
>  				   strerror(errno));
>  	}
> @@ -206,7 +204,7 @@ static int __do_binderfs_test(void)
>  	close(fd);
>  	errno = saved_errno;
>  	if (ret < 0) {
> -		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		rmdir_protect_errno(binderfs_mntpt);
>  		ksft_exit_fail_msg(
>  			"%s - Failed to open perform BINDER_VERSION request\n",
>  			strerror(errno));
> @@ -218,9 +216,9 @@ static int __do_binderfs_test(void)
>  	/* binder transaction with binderfs binder device passed */
>  	ksft_inc_pass_cnt();
>  
> -	ret = unlink("/dev/binderfs/my-binder");
> +	ret = unlink(device_path);
>  	if (ret < 0) {
> -		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		rmdir_protect_errno(binderfs_mntpt);
>  		ksft_exit_fail_msg("%s - Failed to delete binder device\n",
>  				   strerror(errno));
>  	}
> @@ -228,12 +226,13 @@ static int __do_binderfs_test(void)
>  	/* binder device removal passed */
>  	ksft_inc_pass_cnt();
>  
> -	ret = unlink("/dev/binderfs/binder-control");
> +	snprintf(device_path, sizeof(device_path), "%s/binder-control", binderfs_mntpt);
> +	ret = unlink(device_path);
>  	if (!ret) {
> -		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		rmdir_protect_errno(binderfs_mntpt);
>  		ksft_exit_fail_msg("Managed to delete binder-control device\n");
>  	} else if (errno != EPERM) {
> -		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		rmdir_protect_errno(binderfs_mntpt);
>  		ksft_exit_fail_msg(
>  			"%s - Failed to delete binder-control device but exited with unexpected error code\n",
>  			strerror(errno));
> @@ -243,8 +242,8 @@ static int __do_binderfs_test(void)
>  	ksft_inc_xfail_cnt();
>  
>  on_error:
> -	ret = umount2("/dev/binderfs", MNT_DETACH);
> -	keep ?: rmdir_protect_errno("/dev/binderfs");
> +	ret = umount2(binderfs_mntpt, MNT_DETACH);
> +	rmdir_protect_errno(binderfs_mntpt);
>  	if (ret < 0)
>  		ksft_exit_fail_msg("%s - Failed to unmount binderfs\n",
>  				   strerror(errno));
> -- 
> 2.25.1
> 

-- 
Kees Cook
