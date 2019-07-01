Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91DE32718A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 23:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfEVVWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 17:22:47 -0400
Received: from casper.infradead.org ([85.118.1.10]:58264 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbfEVVWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UIpNpeNP8nC6MS6WTkVwKLLD+RER6JawGeArflO+TEA=; b=KjnWOaXbiU1vqTNBUDWhZ742Vs
        lD/wy2x26to+YxMaOa7fgdm5JKMmAUP4EG9WI+2wfgERhA0bodHp4JYHyMAe3SGIzPQ1ELnnMxqlb
        ae+d//cpoeDXONhEIHL25vC8v81Gs4KifKqQNgDL172BKMLbir0BD1FTIkGcZvIJpmsA9tOvNvlQs
        2Em+h/Scuu3IdFl4K3IkpiL5OgfOUF/XQiLrCeXIlnXYdliVJ0NZ2Ahgel7CU7UVvI5xbz3PnlgkM
        aA1q/+YaEPQCf1whrWMTZb6iSvNpesslMi3ax94J5znUU5CIn5EDo/SdR5HGU9dvtNSJpEXxlq6NB
        Cxusm6kg==;
Received: from [179.182.168.126] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTYhA-0006SI-NY; Wed, 22 May 2019 21:22:45 +0000
Date:   Wed, 22 May 2019 18:22:37 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 8/8] scripts/sphinx-pre-install: make it handle Sphinx
 versions
Message-ID: <20190522182237.057d2a99@coco.lan>
In-Reply-To: <20190522205034.25724-9-corbet@lwn.net>
References: <20190522205034.25724-1-corbet@lwn.net>
        <20190522205034.25724-9-corbet@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 22 May 2019 14:50:34 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 
> As we want to switch to a newer Sphinx version in the future,
> add some version detected logic, checking if the current
> version meets the requirement and suggesting upgrade it the
> version is supported but too old.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/sphinx-pre-install | 81 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 74 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index f6a5c0bae31e..e667db230d0a 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -13,7 +13,7 @@ use strict;
>  # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  # GNU General Public License for more details.
>  
> -my $virtenv_dir = "sphinx_1.4";
> +my $conf = "Documentation/conf.py";
>  my $requirement_file = "Documentation/sphinx/requirements.txt";
>  
>  #
> @@ -26,7 +26,9 @@ my $need = 0;
>  my $optional = 0;
>  my $need_symlink = 0;
>  my $need_sphinx = 0;
> +my $rec_sphinx_upgrade = 0;
>  my $install = "";
> +my $virtenv_dir = "sphinx_";
>  
>  #
>  # Command line arguments
> @@ -201,13 +203,15 @@ sub check_missing_tex($)
>  	}
>  }
>  
> -sub check_sphinx()
> +sub get_sphinx_fname()
>  {
> -	return if findprog("sphinx-build");
> +	my $fname = "sphinx-build";
> +	return $fname if findprog($fname);
>  
> -	if (findprog("sphinx-build-3")) {
> +	$fname = "sphinx-build-3";
> +	if (findprog($fname)) {
>  		$need_symlink = 1;
> -		return;
> +		return $fname;
>  	}
>  
>  	if ($virtualenv) {
> @@ -219,6 +223,68 @@ sub check_sphinx()
>  	} else {
>  		add_package("python-sphinx", 0);
>  	}
> +
> +	return "";
> +}
> +
> +sub check_sphinx()
> +{
> +	my $min_version;
> +	my $rec_version;
> +	my $cur_version;
> +
> +	open IN, $conf or die "Can't open $conf";
> +	while (<IN>) {
> +		if (m/^\s*needs_sphinx\s*=\s*[\'\"]([\d\.]+)[\'\"]/) {
> +			$min_version=$1;
> +			last;
> +		}
> +	}
> +	close IN;
> +
> +	die "Can't get needs_sphinx version from $conf" if (!$min_version);
> +
> +	open IN, $requirement_file or die "Can't open $requirement_file";
> +	while (<IN>) {
> +		if (m/^\s*Sphinx\s*==\s*([\d\.]+)$/) {
> +			$rec_version=$1;
> +			last;
> +		}
> +	}
> +	close IN;
> +
> +	die "Can't get recommended sphinx version from $requirement_file" if (!$min_version);
> +
> +	my $sphinx = get_sphinx_fname();
> +	return if ($sphinx eq "");
> +
> +	open IN, "$sphinx --version 2>&1 |" or die "$sphinx returned an error";
> +	while (<IN>) {
> +		if (m/^\s*sphinx-build\s+([\d\.]+)$/) {
> +			$cur_version=$1;
> +			last;
> +		}
> +	}
> +	close IN;
> +
> +	$virtenv_dir .= $rec_version;
> +
> +	die "$sphinx didn't return its version" if (!$cur_version);
> +
> +	printf "Sphinx version %s (minimal: %s, recommended >= %s)\n",
> +		$cur_version, $min_version, $rec_version;
> +
> +	if ($cur_version lt $min_version) {
> +		print "Warning: Sphinx version should be >= $min_version\n\n";
> +		$need_sphinx = 1;
> +		return;
> +	}
> +
> +	if ($cur_version lt $rec_version) {
> +		print "Warning: It is recommended at least Sphinx version $rec_version.\n";
> +		print "         To upgrade, use:\n\n";
> +		$rec_sphinx_upgrade = 1;
> +	}
>  }
>  
>  #
> @@ -540,7 +606,7 @@ sub check_needs()
>  		printf "\tsudo ln -sf %s /usr/bin/sphinx-build\n\n",
>  		       which("sphinx-build-3");
>  	}
> -	if ($need_sphinx) {
> +	if ($need_sphinx || $rec_sphinx_upgrade) {
>  		my $activate = "$virtenv_dir/bin/activate";
>  		if (-e "$ENV{'PWD'}/$activate") {
>  			printf "\nNeed to activate virtualenv with:\n";
> @@ -554,7 +620,8 @@ sub check_needs()
>  			printf "\t$virtualenv $virtenv_dir\n";
>  			printf "\t. $activate\n";
>  			printf "\tpip install -r $requirement_file\n";
> -			$need++;
> +
> +			$need++ if (!$rec_sphinx_upgrade);
>  		}
>  	}
>  	printf "\n";

Please fold this to the patch:

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index e667db230d0a..45427f4289ed 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -255,6 +255,8 @@ sub check_sphinx()
 
 	die "Can't get recommended sphinx version from $requirement_file" if (!$min_version);
 
+	$virtenv_dir .= $rec_version;
+
 	my $sphinx = get_sphinx_fname();
 	return if ($sphinx eq "");
 
@@ -267,8 +269,6 @@ sub check_sphinx()
 	}
 	close IN;
 
-	$virtenv_dir .= $rec_version;
-
 	die "$sphinx didn't return its version" if (!$cur_version);
 
 	printf "Sphinx version %s (minimal: %s, recommended >= %s)\n",


Thanks,
Mauro
