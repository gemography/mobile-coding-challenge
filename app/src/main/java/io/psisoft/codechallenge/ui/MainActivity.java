package io.psisoft.codechallenge.ui;

import android.support.design.widget.BottomNavigationView;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.widget.FrameLayout;
import android.widget.TextView;

import butterknife.BindView;
import butterknife.ButterKnife;
import io.psisoft.codechallenge.R;

public class MainActivity extends AppCompatActivity{

    @BindView(R.id.navigation_view)
    BottomNavigationView bottomNavigationView;
    @BindView(R.id.my_toolbar)
    Toolbar customToolbar;
    @BindView(R.id.my_toolbar_title)
    TextView toolbarTitle;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        ButterKnife.bind(this);

        // Set Action Bar with a custom Toolbar
        setSupportActionBar(customToolbar);

        // Setup the trending fragment
        FragmentManager fragmentManager = getSupportFragmentManager();
        fragmentManager.beginTransaction().replace(R.id.container, new Trending(), "feed").commit();
        bottomNavigationView.setSelectedItemId(R.id.trending);

        // Listen to the selected navigation item
        bottomNavigationView.setOnNavigationItemSelectedListener
                (item -> {
                    Fragment selectedFragment = null;
                    switch (item.getItemId()) {
                        case R.id.trending:
                            selectedFragment = new Trending();
                            toolbarTitle.setText("Trending Repo");
                            break;
                        case R.id.setting:
                            selectedFragment = new Settings();
                            toolbarTitle.setText("Settings");
                            break;
                    }

                    // Replace container with the selected fragment
                    FragmentTransaction transaction = getSupportFragmentManager().beginTransaction();
                    transaction.replace(R.id.container, selectedFragment);
                    transaction.commit();
                    return true;
                });
    }

}
